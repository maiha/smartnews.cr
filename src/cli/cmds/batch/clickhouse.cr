class Cmds::BatchCmd
  def import_clickhouse_tsv
    shell = Shell::Seq.new
    shell.dryrun = config.dryrun?

    db.measure {
      logger.info "#{PROGRAM_NAME} clickhouse replace #{partition_key} #{report_tsv_path}"
      shell.run "#{PROGRAM_NAME} clickhouse replace #{partition_key} #{report_tsv_path}"
    }

    if shell.dryrun?
      STDOUT.puts shell.manifest
    else
      unless shell.success?
        msg = "FAIL: %s\n%s" % [shell.last.cmd, shell.stderr]
        abort msg
      end
      logger.info "[clickhouse] (tsv) [%s]" % [db.last]
    end
  end
  
end
