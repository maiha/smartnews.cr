class Cmds::BatchCmd
  private var insight_since : String = target_date.to_s("%F")
  private var insight_until : String = target_date.to_s("%F")

  def recv_insight
    hint = "[recv] insight"
    logger.debug "start: #{hint}"
    
    house = house(Smartnews::Proto::Insight)

    # iterate job
    done_count = 0

    accounts = house(Smartnews::Proto::Account).load
    accounts.each_with_index do |account, i|
      # account: {"accountId": "1000000", "name": "SmartNews, Inc"}
      aid = account.account_id.to_s
      raise Smartnews::Fatal.new("accounts[#{i}]: missing accountId") if aid.empty?

      room  = house.chdir(File.join(house.dir, "data", aid))
      label = "%s(%s/%s)[%s]" % [hint, i+1, accounts.size, aid]

      converter = converter(Array(Smartnews::Converter::Insight))

      recv_insight_impl(room, converter, aid, label)
      done_count += 1 if room.meta[META_DONE]?
    end

    # mark meta.done if all metas have been finished.
    record_count = house.load.size # not use house.count to avoid cached count in meta
    if done_count == accounts.size
      house.meta[META_DONE] = "got #{record_count}"
    end

    # job summary
    msg = "#{hint} got #{record_count} records (in recv: #{recv})"
    update_status msg, logger: "INFO", flush: true

    logger.debug "done: #{hint}"
  end

  private def recv_insight_impl(house, converter, aid, hint)
    @retry_attempts = 0       # reset retry

    # if done, nothing to do
    if msg = house.meta[META_DONE]?
      msg = "%s (already %s)" % [hint, msg]
      update_status msg, logger: "INFO", flush: true
      return false
    end

    # if 400, nothing to do
    if house.meta[META_STATUS]? == "400"
      msg = "%s (skip: ERROR 400)" % [hint]
      update_status msg, logger: "ERROR", flush: true
      raise msg
    end

    client = new_client
    
    # check resumable url, or build initial url
    if url = house.resume?
      logger.info "%s found suspended job" % [hint]
    else
      url = "/api/v1.0/accounts/#{aid}/insights -d level=creative -d since=#{insight_since} -d until=#{insight_until}"
      house.checkin(url)
      logger.debug "%s created new url: %s" % [hint, url]
    end

    loop_counter = 0
    self.retry_attempts = 0
    max_attempts = config.batch_max_attempts
    recv.start

    while (url = house.resume?) && !house.meta[META_DONE]?
      loop_counter += 1 if retry_attempts == 0 # increment only when not retry

      label = "#{hint}##{loop_counter}"
      if retry_attempts > 0
        label = "#{label}(retry #{retry_attempts})"
      end

      if loop_counter > max_attempts
        raise "#{label} reached max loop limit(#{max_attempts})"
      end        

      begin
        recv_impl(client, url, house, converter, hint)
        break
      rescue err : Smartnews::Api::Error
        res = err.response
        case res.code
        when 500..599
          # retry for server errors
          update_status err.to_s, logger: "INFO"
          self.retry_attempts += 1
        else
          # otherwise, raise as fatal
          raise err
        end
      end
    end

    recv.stop

    msg = "%s %s [%s]" % [hint, house.count, recv.last.to_s]
    update_status msg, logger: "INFO", flush: true

    return true

  rescue err
    house.meta[META_ERROR] = err.to_s if house
    raise err
  end

end
