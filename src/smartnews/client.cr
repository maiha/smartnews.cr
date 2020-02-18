require "./proto/**"
require "./errors"
require "./converter/**"
require "./callback"
require "./strategy"
require "./request"
require "./response"

module Smartnews
  class Client
    include Smartnews::Callback
    include Smartnews::Strategy

    var api  : Api  = Api::Get.new("/api")
    var auth : Auth = Smartnews::Auth::AccessToken.new("")
    var host : Host = Host.default

    var logger : Logger

    def initialize(api = nil, auth = nil, host = nil, logger : Logger? = nil)
      self.api  = api
      self.auth = auth
      self.host = host

      @logger = logger || Logger.new(nil)
      self.strategy = Strategy::Libcurl.new
    end

    ######################################################################
    ### shortcuts for Smartnews class

    def api=(path : String)
      @api = Smartnews::Api::Get.parse(path)
    end

    def auth=(access_token : String)
      @auth = Smartnews::Auth::AccessToken.new(access_token)
    end

    def host=(host : String)
      @host = Smartnews::Host.new(host)
    end

    def strategy=(v : Strategy::Base) : Client
      @strategy = v
      strategy.logger = logger
      return self
    end

    def dryrun! : Client
      self.strategy= Smartnews::Strategy::Dryrun.new
    end

    def libcurl! : Client
      self.strategy= Smartnews::Strategy::Libcurl.new
    end

    ######################################################################
    ### API methods

    # See ./api/*.cr
    
    ######################################################################
    ### HTTP methods
    
    def get(path : String, data = {} of String => String) : Response
      api = Api::Get.parse(path)
      api.data.merge!(data)
      execute(api: api)
    end

    def post(path : String, data = {} of String => String) : Response
      api = Api::Post.parse(path)
      api.data.merge!(data)
      execute(api: api)
    end

    ######################################################################
    ### internal methods

    def request(api : Api? = nil, auth : Auth? = nil, host : Host? = nil)  : Request
      Request.new(api || api?, auth || auth?, host || host?)
    end

    def request(req : Request) : Request
      req
    end

    def validate(req : Request)
      req.api?  || raise "api not found"
      req.auth? || raise "auth not found"
      req.host? || raise "host not found"
      req.authorize!
    end
  end
end
