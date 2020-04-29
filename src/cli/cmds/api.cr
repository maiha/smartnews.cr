Cmds.command "api" do
  var client : Smartnews::Client = config.smartnews_client.tap(&.logger = logger)
  
  delegate verbose?, to: config

  def before
    self.logger = Logger.new(nil)
  end
  
  usage "accounts"
  task accounts do
    path = "/api/v1.0/accounts"
    res = client.get(path)
    show(res)
  end

  usage "insights <account_id> # GET /accounts/<ACCOUNT_ID>/insights"
  task insights, "<account_id>" do
    path = "/api/v1.0/accounts/#{arg1}/insights"
    res = client.get(path)
    show(res)
  end

  usage "get <ANY_PATH> # '/api/v1.0/accounts/12345/insights -d level=campaign'"
  task get, "ANY_PATH_WITH_PARAMETERS" do
    res = client.get(arg1)
    show(res)
  end
  
  private def show_headers(res : Smartnews::Response)
    hash = res.headers.to_h
    lines = Array(Array(String)).new
    hash.each do |k,v|
      lines << [k.to_s, v.inspect]
    end
    puts Pretty.lines(lines, delimiter: " ").split(/\n/).map(&.gsub(/\s+$/,"")).join("\n")
  rescue Smartnews::Response::Error
    puts "N/A"
  rescue err
    puts "!!!!!!!!!!! #{err} !!!!!!!!!!!!"
    puts res.header
  end

  private def show_body(res : Smartnews::Response)
    puts Pretty.json(res.body, color: !!config.colorize?)
  rescue Smartnews::Response::Error
    puts "N/A"
  rescue
    puts res.body
  end

  private def show(res : Smartnews::Response)
    if verbose?
      puts "%s %s %s" % [res.code, res.req.api.method, res.req.url]
      puts "----------------------------------------"
      show_headers(res)
      puts "----------------------------------------"
    end
    show_body(res)
  end
end
