class Cmds::BatchCmd
  var tsv_sep   = '\t'
  var tsv_quote = CSV::Builder::Quoting::NONE
  
  # - convert <TAB> to <SPACE>
  # - convert <BACKSLASH> to <BACKSLASH><BACKSLASH>

  def tsv_impl
    hint  = "[tsv] report"

    # touch output path for append
    Pretty::File.rm_f(report_tsv_path)

    create = Smartnews::Converter::Report.clickhouse_create
    keys = create.columns.map(&.name)
    pbs = house(Smartnews::Proto::Insight).load
    logger.info "%s house records:%d" % [hint, pbs.size]

    disk.measure {
      buf = CSV.build(quoting: tsv_quote, separator: tsv_sep) do |csv|
        pbs.each do |pb|
          vals = Array(String).new
          keys.each do |key|
            case key
            when "date"
              vals << partition_key
            else
              vals << tsv_serialize(pb[key]?)
            end
          end
          csv.row(vals)
        end
      end

      Pretty::File.write(report_tsv_path, buf)
    }
  end

  private def tsv_serialize(v) : String
    # Nullable
    return "\\N" if v.nil?

    # convert TAB and RET to spaces
    v = v.to_s.gsub('\t', ' ').gsub('\n', ' ')
    # escape backslashes
    v = escape_backslashes(v)

    return v
  end

  # backslash string in macro fails
  # see https://github.com/crystal-lang/crystal/issues/8064
  private def escape_backslashes(v)
    v.gsub('\\', "\\\\")
  end
end
