# recoverable error (5xx)
class Smartnews::Error < Exception
end

# token errors
class Smartnews::ErrorResponse < Smartnews::Error
  JSON.mapping({
    code:      Int64? , # 1
    message:   String?, # "Bid Too Low: Your bid is below the minimum for its placement."
    parameter: String?, # "bidAmount"
  })
end

# fatal error (bug)
class Smartnews::Fatal < Smartnews::Error
end

# unrecoverable error (4xx)
class Smartnews::Denied < Smartnews::Fatal
end

# token errors
class Smartnews::TokenError < Smartnews::Denied
end

class Smartnews::NotAuthorized < Smartnews::TokenError
end

class Smartnews::TokenExpired < Smartnews::NotAuthorized
end

