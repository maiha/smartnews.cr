module Smartnews::Auth
  class NotAuthorizedError < Exception
  end

  abstract def authorize!(req : Smartnews::Request)

  class AccessToken
    include Auth

    var access_token : String
    
    def initialize(@access_token)
    end

    def authorize!(request) : Bool
      api = request.api
      if token = access_token?
        if !token.empty?
          api.apply_access_token!(token)
          return true
        end
      end
      raise NotAuthorizedError.new
    end
  end

  class Nothing
    include Auth

    # No needs to authorize.
    # Maybe global page, or access_key has already been embeded.
    def authorize!(request) : Bool
      return true
    end
  end
end
