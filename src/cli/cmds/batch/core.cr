# add methods to open class
class Cmds::BatchCmd
  ### API
  var api_base_interval : Time::Span = 3.seconds # interval between retries

  ### for tasks
  var api  = Pretty::Stopwatch.new # total time of API
  var db   = Pretty::Stopwatch.new # total time of DB
  var disk = Pretty::Stopwatch.new # total time of DISK
  var task = Pretty::Stopwatch.new # total time of TASK
  var recv = Pretty::Stopwatch.new # total time of RECV

  var disable_after : Bool = false
  
  var target_date  : Time          # logical date for the resources
  var target_ymd   : String        # logical ymd for the resources
  
  var work_dir     : String        # abs path
  var global_dir   : String        # abs path
  var today_dir    : String        # abs path
  var executed_at  : Time
  var console      : Pretty::Logger = Pretty::Logger.new(Logger.new(STDERR))
  var batch_logger : Pretty::Logger = Pretty::Logger.new(Logger.new(nil))

  var report_tsv_path : String = "#{today_dir}/report.tsv"
  var partition_key   : String = target_date.to_s("%F")
  
  # oneline status for the current task
  var status_callback : Proc(Logger, Nil)
  var status_logger : Pretty::Logger = Pretty::Logger.new(Logger.new(nil))

  def before
    self.executed_at  = Pretty::Time.now

    self.work_dir   = File.expand_path(config.batch_work_dir).chomp("/")
    self.global_dir = File.expand_path(config.batch_global_dir).chomp("/")

    Dir.mkdir_p(work_dir)
    Dir.mkdir_p(global_dir)

    setup_target_date!(arg1?)

    self.today_dir  = "#{work_dir}/#{target_ymd}"
    
    self.batch_logger  = build_batch_logger("#{today_dir}/#{task_name}.log")
    self.status_logger = config.build_batch_status_logger?

    logger.info "target time: %s" % target_ymd
    task.start
  end

  def after
    return if disable_after?

    task.stop
    # if `before` has not finished successfully, `today_dir` is not also set.
    return unless today_dir?

    if err = error?
      logger.error("dir: #{Dir.current}")
      msg = Pretty.truncate(err.to_s.gsub(/\s+/, " "), size: 100)
      update_status(msg, logger: "ERROR")
    end
    flush_status_log

    if ! (error = logger.memory?.to_s).empty?
      STDERR.puts error
    end

    msg = "#{task}, API:#{api}, DB:#{db}, IO:#{disk}, MEM:#{max_mem}"
    if task_state.finished?
      logger.info "[task:done] #{msg}"
    else
      logger.error "[task:abort] #{msg}"
    end
  end

  private def update_status(msg : String, logger = nil, flush = false)
    if logger
      severity = Logger::Severity.parse(logger)
      self.logger.log(severity, msg)
    else
      severity = Logger::Severity::INFO
    end
    @status_callback = ->(log : Logger){ log.log(severity, msg); nil }
    flush_status_log if flush
  end

  def flush_status_log
    if callback = status_callback?
      callback.call(status_logger)
      @status_callback = nil
    end
  end

  private var max_mem_error_reported : Bool = false

  private def max_mem : String
    Pretty.process_info(skip_invalid: true).max.to_s
  rescue err
    # report error only once
    if !max_mem_error_reported?
      logger.warn err.to_s
      @max_mem_error_reported = true
    end
    return "---"
  end

  private def setup_target_date!(v)
    self.target_date = Pretty.date(v.to_s)
    self.target_ymd  = target_date.to_s("%Y%m%d")
  rescue err
    if v
      hint = "but got #{v.inspect} (#{err})"
    else
      hint = "try `batch #{task_name} today` first"
    end
    raise Cmds::ArgumentError.new("`#{task_name}` needs <date> for arg1, #{hint}")
  end

  private def enabled?(name) : Bool
    # Smartnews::Proto::AdAccount
    name = Pretty.underscore(name.to_s.split(/::/).last.to_s)
    config.enabled_recvs.includes?(name)
  end

  private def build_batch_logger(path : String) : Pretty::Logger
    Dir.mkdir_p(File.dirname(path))
    logger = config.build_logger(path: path)
    Pretty::Logger.new(logger, memory: "=ERROR")
  end

  def logger : Pretty::Logger
    batch_logger? || console
  end
end
