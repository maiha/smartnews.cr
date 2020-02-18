Cmds.command "clickhouse" do
  usage "replace account data.tsv"
  usage "execute smartnews  # run sql(smartnews)"
  
  var host  : String = config.clickhouse_host
  var port  : Int32  = config.clickhouse_port
  var db    : String = config.clickhouse_db
  var table : String = config.clickhouse_table

  var logger : Logger = build_logger(path: "clickhouse.log")
  var shell = Shell::Seq.new
  
  usage "replace 2017-11-13 report.tsv"
  # Update ClickHouse data to atomic (using REPLACE PARTITION)
  # 1. Create if target table does not exist
  # 2. Create table for REPLACE
  # 3. Insert new data into REPLACE table
  # 4. Replace target PARTITION with REPLACE table
  # 5. Delete REPLACE table
  task "replace", "<DATE> <REPORT_TSV>" do
    partition_by  = "date"
    partition_key = arg1
    input_file    = arg2
    current_table = table
    replace_table = "tmp_#{current_table}_replacing"
    clickhouse    = "clickhouse-client -h #{host}"

    count_current_sql = "SELECT count(*) FROM #{db}.#{current_table} WHERE #{partition_by} = '#{partition_key}'"

    # shell
    shell.dryrun = config.dryrun?

    # 1. Create if target table does not exist
    create_sql = build_create_sql(current_table, drop_table: false)
    run! "#{clickhouse} -mn", stdin: create_sql
    
    # 2. Create table for REPLACE
    create_sql = build_create_sql(replace_table, drop_table: true)
    run! "#{clickhouse} -mn", stdin: create_sql

    # 3. Insert new data into REPLACE table
    run! "#{clickhouse} -d #{db} -q 'INSERT INTO #{replace_table} FORMAT TSVWithNames' < #{input_file}"

    # Save the number of data before execution
    current_table_count = run!(clickhouse, stdin: count_current_sql)
    replace_table_count = run!("#{clickhouse} -q 'SELECT count(*) FROM #{db}.#{replace_table}'").stdout.chomp
    
    # 4. Replace target PARTITION with REPLACE table
    replace_sql = "ALTER TABLE #{current_table} REPLACE PARTITION '#{partition_key}' FROM #{replace_table}"
    run! "#{clickhouse} -d #{db}", stdin: replace_sql

    # 5. Delete REPLACE table
    run!("#{clickhouse} -d #{db} -q 'DROP TABLE IF EXISTS #{replace_table}'")

    # Display execution results
    if config.dryrun?
      puts shell.manifest
    else
      current_count = run!(clickhouse, stdin: count_current_sql).stdout.chomp
      successfully_replaced = (replace_table_count == current_count)
      logger.info <<-EOF
        Execution result
          ClickHouse   : -h #{host} -d #{db}
          input file   : #{input_file}
          partition    : #{partition_key}
          current data : #{current_table_count}
          replace data : #{replace_table_count}
          result data  : #{successfully_replaced ? green(current_count) : red(current_count)}
        EOF

      if successfully_replaced
        logger.info green("Successfully replaced")
      else
        raise Cmds::Halt.new("Failed: Data mismatch. expected #{replace_table_count}, but got #{current_count}")
      end
    end
  end

  private def build_create_sql(table_name : String, drop_table : Bool) : String
    create = Smartnews::Converter::Report.clickhouse_create
    create.create  = "CREATE TABLE IF NOT EXISTS"
    create.db      = db
    create.table   = table_name
    create.engine  = config.clickhouse_engine
    create_sql = String.build do |s|
      s.puts "CREATE DATABASE IF NOT EXISTS #{db};"
      s.puts "DROP TABLE IF EXISTS #{db}.#{create.table};" if drop_table
      s.puts create.to_sql
    end

    return create_sql
  end

  protected def run!(cmd : String, stdin : String? = nil) : Shell
    if stdin
      io = IO::Memory.new
      io.print stdin
      io.rewind
      logger.debug("# STDIN: #{stdin}")
      logger.info("shell: #{cmd}")
      shell.run!(cmd, stdin: io)
    else
      logger.info("shell: #{cmd}")
      shell.run!(cmd)
    end
    err = shell.last.stderr.chomp
    logger.warn "(stderr) #{err}" if ! err.empty?
    return shell.last
  end

  private def build_logger(path : String) : Pretty::Logger
    Dir.mkdir_p(File.dirname(path))
    logger = config.build_logger(path: path)
    Pretty::Logger.new(logger, memory: "=ERROR")
  end
end
