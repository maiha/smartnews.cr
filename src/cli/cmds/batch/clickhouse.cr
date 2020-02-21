class Cmds::BatchCmd
  def import_clickhouse_tsv
    hint = "[clickhouse] (tsv)"
    logger.debug "start: #{hint}"

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
      logger.info "%s [%s]" % [hint, db.last]
    end
    logger.debug "done: #{hint}"
  end
  
end
