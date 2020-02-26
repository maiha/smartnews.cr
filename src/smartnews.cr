{% begin %}
@[Link("curl", ldflags: "`command -v pkg-config > /dev/null && pkg-config --libs --silence-errors {{ flag?(:static) ? "--static".id : "".id }} libcurl || printf %s '-lcurl'`")]
lib LibCurl
end
{% end %}

require "logger"
require "json"
require "http"
require "uri"

require "var"
require "pretty"
require "curl"

require "./proto/**"
require "./smartnews/client"
