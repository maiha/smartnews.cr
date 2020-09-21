class Smartnews::Config < TOML::Config
  class Error < Exception; end

  var clue : String

  # base
  bool "verbose"
  bool "dryrun"
  bool "colorize"
  i32  "limit"
  str  "fields"
  str  "format"

  # api
  str  "api/access_token"
  bool "api/logging"
  str  "api/url"
  i32  "api/keep_remaining"

  f64 "api/dns_timeout"
  f64 "api/connect_timeout"
  f64 "api/read_timeout"

  # batch
  str  "batch/work_dir"
  str  "batch/global_dir"
  str  "batch/status_log"
  i32  "batch/max_attempts"
  bool "batch/gc"
  bool "batch/pb_logging"
  bool "batch/video_metrics"
  
  # clickhouse
  str "clickhouse/host"
  i32 "clickhouse/port"
  str "clickhouse/db"
  str "clickhouse/table"
  str "clickhouse/engine"
  
  var enabled_recvs : Set(String) = build_enabled_recvs

  def api_cmd?(model) : String?
    self.str?("#{model}/cmd")
  end

  def smartnews_client : Smartnews::Client
    client = Smartnews::Client.new(host: api_url)
    client.auth = api_access_token    
    strategy = Smartnews::Strategy::Libcurl.new
    {% for x in %w( dns_timeout connect_timeout read_timeout ) %}
      strategy.{{x.id}} = api_{{x.id}}?
    {% end %}
    client.strategy = strategy
    client.dryrun! if dryrun?
    client
  end

  def batch_publisher_ids : Array(Int32)
    ints("batch/publisher_ids")
  end

  private def build_enabled_recvs
    set = Set(String).new
    toml["batch"].as(Hash).each do |k,v|
      if v && (k =~ /^recv_(.*?)$/)
        set << $1
      end
    end
    set
  end

  # callback for initialize
  def init!
  end

  def build_logger(path : String?) : Logger
    build_logger(self.toml["logger"]?, path)
  end

  def build_logger(hash, _path : String?) : Logger
    case hash
    when Nil
      return Logger.new(nil)
    when Array
      Pretty::Logger.new(hash.map{|i| build_logger(i, _path).as(Logger)})
    when Hash
      hint = hash["name"]?.try{|s| "[#{s}]"} || ""
      hash["path"] ||= _path || raise Error.new("logger.path is missing")
      logger = Pretty::Logger.build_logger(hash)
      logger.formatter = "{{mark}},[{{time=%H:%M}}] #{hint}{{message}}"
      return logger
    else
      raise Error.new("logger type error (#{hash.class})")
    end
  end

  def build_batch_status_logger?
    if path = batch_status_log?
      Dir.mkdir_p(File.dirname(path)) if path != "STDOUT" && path != "STDERR"
      opts = {
        "path"   => path,
        "mode"   => "a+",
        "level"  => "INFO",
        "format" => "{{mark}},[{{time=%H:%M}}] {{message}}",
      }
      return Pretty::Logger.new(Pretty::Logger.build_logger(opts))
    else
      return nil
    end    
  end

  def to_s(io : IO)
    max = @paths.keys.map(&.size).max
    @paths.each do |(key, val)|
      io.puts "  %-#{max}s = %s" % [key, val]
    end
  end

  private def pretty_dump(io : IO = STDERR)
    io.puts "[config] #{clue?}"
    io.puts to_s
  end
end

class Smartnews::Config < TOML::Config
  def self.parse_file(path : String)
    super(path).tap(&.clue = path)
  end

  def self.empty
    parse("")
  end

  @@current : Smartnews::Config = empty
  def self.current : Smartnews::Config
    @@current
  end

  def self.current=(v) : Smartnews::Config
    @@current = v
  end

  def self.sample
    parse(SAMPLE)
  end
end

Smartnews::Config::SAMPLE = <<-EOF
[api]
access_token    = ""

url             = "https://partners.smartnews-ads.com"
logging         = true

dns_timeout     = 3.0
connect_timeout = 5.0
read_timeout    = 300.0

[batch]
work_dir        = "recv"
global_dir      = "global"
status_log      = "log"
gc              = true
pb_logging      = false
max_attempts    = 5
video_metrics   = true

[clickhouse]
host   = "localhost"
port   = 9000
db     = "smartnews"
table  = "reports"
engine = "MergeTree PARTITION BY date ORDER BY date SETTINGS index_granularity = 8192"

[[logger]]
progname = "smartnews"
level    = "DEBUG"

[[logger]]
path     = "STDOUT"
level    = "INFO"
colorize = true

[[logger]]
path     = "warn"
mode     = "a+"
level    = "=WARN"
colorize = true

[[logger]]
path     = "err"
mode     = "a+"
level    = "=ERROR"
colorize = true
EOF
