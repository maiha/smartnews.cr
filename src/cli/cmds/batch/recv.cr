# add methods to open class
class Cmds::BatchCmd
  META_DONE         = "done"
  META_STATUS       = "status"
  META_CURRENT_URL  = "current_url"
  META_INFO         = "info"
  META_WARN         = "warn"
  META_ERROR        = "error"

  # cache config values
  private var retry_attempts : Int32
  private var visited_urls = Set(String).new

  macro converter(klass)
    Smartnews::Converter::Payload({{klass.id}})
  end

  # ```crystal
  # client = new_client
  # url    = "/api/v1.0/accounts"
  # house  = house(Smartnews::Proto::Account)
  # converter = converter(Array(Smartnews::Converter::Account))
  # hint   = "accounts"
  # recv_impl(client, url, house, converter, hint)
  # ```
  private def recv_impl(client, url, house, converter, hint)
    #
    # ```
    # recv
    # `-- 20200219
    #     |-- HttpCall
    #     |   |-- data
    #     |   |   |-- 00001.pb.gz
    #     |   |   `-- 00002.pb.gz
    #     |   `-- meta
    #     `-- Smartnews::Proto::Account
    #         |-- data
    #         |   `-- 00001.pb.gz
    #         `-- meta
    #             |-- count
    #             |-- done
    #             `-- status
    # ```
    client.api = url

    # validte url before execute
    client.before_execute {|req|
      url = req.url
      visited_urls.includes?(url) &&
        raise "[BUG] already visited: #{url}"
      logger.debug "#{hint} #{url}"
    }

    client.after_execute {|req, res|
      if res.try{|r| r.success? && r.client_error? }
        visited_urls << req.url
      end
    }

    api.start
    res = client.execute
    api.stop

    # write status into meta
    house.meta[META_STATUS] = res.code.to_s

    res.success!
    pbs = converter.from_json(res.body).to_pbs
    house.write(pbs, {META_DONE => "got #{pbs.size}"})
  end

  private def new_client
    client = config.smartnews_client
    client.logger = logger
    client.after_execute {|req, res|
      pb = build_http_call(req, res)
      http_house.save(pb)
    }
    return client
  end
end
