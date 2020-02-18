module Smartnews::Api
  class Get
    include Api

    def initialize(@path : String, @data : Hash(String, String)? = nil, @form : Hash(String, String)? = nil)
      @method = Method::GET
    end

    def request_path : String
      build_request_path
    end
    
    def apply_access_token!(token : String)
      head["X-Auth-Api"] = token
    end

    def validate!
      # NOP
    end
  end
end
