Cmds.command "batch" do
  # [Task]
  #   clean
  task clean, "<date>" do
    Pretty.rm_rf(today_dir)
    logger.info "Deleted #{today_dir}"
  end
  
  usage "run 2017-11-13"
  # [Task]
  #   run
  # [Responsibility]
  #   meta task of all tasks
  # [Input]
  #   See each task
  # [Output]
  #   See each task
  task "run", "<date>" do
    invoke_task("recv")
    invoke_task("tsv")
    invoke_task("db")
  end

  # [Task]
  #   recv
  # [Responsibility]
  #   receive all data as json from Smartnews by invoking api
  # [Input]
  #   API:
  # [Output]
  #   FILE: Smartnews::Proto::*/
  task "recv", "<date>" do
    recv_account
    recv_insight
    recv_campaign
    recv_creative

    update_status "[recv:done] API:#{api} MEM:#{max_mem}", logger: "INFO"

  rescue err
    update_status "[recv] #{err.to_s}", logger: "FATAL"
    raise err
  end

  task "tsv", "<date>" do
    tsv_impl

    update_status "[tsv:done] MEM:#{max_mem}", logger: "INFO"
  end  

  task "db", "<date>" do
    import_clickhouse_tsv

    update_status "[clickhouse:done] DB:#{db} MEM:#{max_mem}", logger: "INFO"
  end

  task "gc" do
    return if !config.batch_gc?

    gc_storage HttpCall
    gc_tsv

    update_status "[gc:done] DISK:#{disk} MEM:#{max_mem}", logger: "INFO"
  end
end

require "./batch/*"
