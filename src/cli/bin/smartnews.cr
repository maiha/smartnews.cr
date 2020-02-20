require "../../cli/cli"

class Cli::Main
  include Opts
  include GlobalHelper

  CONFIG_FILE = ".smartnewsrc"
  {% begin %}
  TARGET_TRIPLE = "{{`crystal -v | grep x86_64 | cut -d: -f2`.strip}}"
  {% end %}

  USAGE = <<-EOF
    usage: {{program}} [options] <commands>

    options:
    {{options}}

    commands:
      #{Cmds.names.sort.join(", ")}
    EOF

  option config_path  : String?, "-K <config>", "Smartnews config file (default: '~/.smartnewsrc')", nil

  option pass    : String?, "-a <access_token>", "Specify the access token for api account", nil
  option fields  : String?, "-f <fields>", "[pb] Select only these fields", nil
  option limit   : Int32?, "-l <limit>", "[pb] Select only first limit records", nil
  option format  : String?, "-F <format>", "[pb] Specify format", nil
  option dryrun  : Bool  , "-n", "Dryrun mode", false
  option verbose : Bool  , "-v", "Verbose output", false
  option nocolor : Bool  , "-C", "Disable colored output", false
  option version : Bool  , "--version", "Print the version and exit", false
  option help    : Bool  , "--help"   , "Output this help and exit" , false

  var cmd : Cmds::Cmd
  var config : Smartnews::Config

  def run
    # setup
    self.config = load_config
    config.verbose  = verbose
    config.dryrun   = dryrun
    config.colorize = !nocolor
    config.limit    = limit.not_nil!.to_i64 if limit
    config.fields  = fields
    config.format  = format
    config.init!

    Smartnews::Config.current = config

    # execute
    (self.cmd = Cmds[args.shift?.to_s].new).run(args)
  end

  private def load_config : Smartnews::Config
    # When the user specifies the file name
    if path = config_path
      # The error is left to Config when the specified file doesn't exist
      return Smartnews::Config.parse_file(path)
    end

    # Scan all parent directories up to "/"
    dir = File.real_path("./")
    while !dir.empty?
      if config = load_config?(dir)
        return config
      end
      break if dir == "/"
      dir = File.expand_path(File.join(dir, ".."))
    end      

    return load_config?("~/") || Smartnews::Config.empty
  end

  private def load_config?(dir : String) : Smartnews::Config?
    path = File.expand_path(File.join(dir, CONFIG_FILE))
    if File.exists?(path)
      Smartnews::Config.parse_file(path)
    else
      nil
    end
  end

  private def pretty_tasks(cmd, prefix)
    array = cmd.class.usages.map{|help| help.split(/\s*#\s*/, 2)}
    Pretty.lines(array, delimiter: "  # ").chomp.split(/\n/).map{|line|
      "%s%s %s %s" % [prefix, PROGRAM_NAME, cmd.class.cmd_name, line.strip]
    }.join("\n")
  end

  def on_error(err)
    case err
    when Cmds::Finished
      exit 0
    when Smartnews::Config::Error, TOML::Config::NotFound
      STDERR.puts red("ERROR: #{err}")
      exit 1
    when Cmds::ArgumentError
      STDERR.puts red(err.to_s)
      STDERR.puts cmd.class.pretty_usage(prefix: " ")
      exit 2
    when Cmds::CommandNotFound
      STDERR.puts show_usage
      exit 3
    when Cmds::TaskNotFound
      task_names = cmd.class.task_names
      STDERR.puts red("ERROR: Task Not Found (current: '#{err.name}')")
      STDERR.puts "[possible tasks]"
      STDERR.puts "  %s" % task_names.join(", ")
      STDERR.puts
      STDERR.puts "[examples]"
      STDERR.puts pretty_tasks(cmd, prefix: "  ")
      exit 4
    when Smartnews::Dryrun
      STDOUT.puts err.inspect
    when Smartnews::Denied, Smartnews::Error
      STDERR.puts red(err.to_s)
      exit 20
    when Errno
      STDERR.puts red(err.to_s)
      exit 91
    when Cmds::Abort
      STDERR.puts red(Pretty.error(err).message)
      cmd.logger.error "ERROR: #{err}"
      exit 99
    when Cmds::Halt
      STDERR.puts red(err.to_s)
      exit 100
    else
      STDERR.puts red(Pretty.error(err).message)
      cmd.logger.error "ERROR: #{err} (#{err.class.name})"
      cmd.logger.error(err.inspect_with_backtrace)
      STDERR.puts red(Pretty.error(err).where.to_s) # This may kill app
      exit 255
    end
  end

  def show_version
    "#{PROGRAM} #{VERSION} #{TARGET_TRIPLE} crystal-#{Crystal::VERSION} #{String.new(LibCurl.curl_version)}"
  end
end

Cli::Main.run
