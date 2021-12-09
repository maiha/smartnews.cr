class Cmds::BatchCmd
  var tsv_sep   = '\t'
  var tsv_quote = CSV::Builder::Quoting::NONE
  
  # - convert <TAB> to <SPACE>
  # - convert <BACKSLASH> to <BACKSLASH><BACKSLASH>

  def tsv_impl
    hint = "[tsv] report"
    logger.debug "start: #{hint}"

    # touch output path for append
    Pretty::File.rm_f(report_tsv_path)

    create = Smartnews::Converter::Report.clickhouse_create
    keys = create.columns.map(&.name)

    insights = house(Smartnews::Proto::Insight).load
    logger.info "%s %s records:%d" % [hint, "insight", insights.size]

    campaigns = house(Smartnews::Proto::Campaign).load
    logger.info "%s %s records:%d" % [hint, "campaign", campaigns.size]

    creatives = house(Smartnews::Proto::Creative).load
    logger.info "%s %s records:%d" % [hint, "creative", creatives.size]

    campaigns_hash = Hash(String, Smartnews::Proto::Campaign).new
    campaigns.each_with_index do |c, i|
      cid = c.campaign_id || (logger.debug "house(Campaign)##{i}: campaign_id is missing: #{c.inspect}"; next)
      campaigns_hash[cid] = c
    end

    creatives_hash = Hash(String, Smartnews::Proto::Creative).new
    creatives.each_with_index do |c, i|
      cid = c.creative_id || (logger.debug "house(Creative)##{i}: creative_id is missing: #{c.inspect}"; next)
      creatives_hash[cid] = c
    end

    disk.measure {
      buf = CSV.build(quoting: tsv_quote, separator: tsv_sep) do |csv|
        csv.row(keys)           # header
        insights.each do |insight|
          vals = Array(String).new
          keys.each do |key|
            if key == "date"
              vals << partition_key
            elsif f = Smartnews::Proto::Insight::Fields[key]?
              vals << tsv_serialize(insight[key]?, f)
            elsif f = Smartnews::Proto::Campaign::Fields[key]?
              cid = insight.campaign_id.to_s
              campaign = campaigns_hash[cid]? || (
                logger.warn "campaign not found: insight=#{insight.inspect}"
                nil
              )
              vals << tsv_serialize(campaign.try{|c| c[key]?}, f)
            elsif f = Smartnews::Proto::Creative::Fields[key]?
              cid = insight.creative_id.to_s
              creative = creatives_hash[cid]? || (
                logger.warn "creative not found: insight=#{insight.inspect}"
                nil
              )
              vals << tsv_serialize(creative.try{|c| c[key]?}, f)
            elsif f = Smartnews::Proto::Imageinfo::Fields[key]?
              cid = insight.creative_id.to_s
              imageset = creatives_hash[cid].imageset
              max_size_area = 0
              if imageset
                max_size_imageinfo_val = nil
                imageset.each do |imageinfo|
                  width = imageinfo.width
                  height = imageinfo.height
                  if width.nil? || height.nil?
                  else
                    area = width * height
                    if max_size_area < area
                      max_size_area = area
                      max_size_imageinfo_val = imageinfo.try{|c| c[key]?}
                    end
                  end
                end
                vals << tsv_serialize(max_size_imageinfo_val, f)
              end
            else
              raise "[BUG] #{hint} got unknown key: #{key.inspect}"
            end
          end
          csv.row(vals)
        end
      end

      Pretty::File.write(report_tsv_path, buf)
    }
    logger.debug "done: #{hint}"
  end

  private def tsv_serialize(v, field = nil) : String
    # Nullable
    return "\\N" if v.nil?

    # convert TAB and RET to spaces
    v = v.to_s.gsub('\t', ' ').gsub('\n', ' ')
    # escape backslashes
    v = escape_backslashes(v)

    # clickhouse expects UInt8 for Boolean
    if field.try(&.pb_type) == "bool"
      case v
      when "true"  ; v = "1"
      when "false" ; v = "0"
      end
    end
    
    return v
  end

  # backslash string in macro fails
  # see https://github.com/crystal-lang/crystal/issues/8064
  private def escape_backslashes(v)
    v.gsub('\\', "\\\\")
  end
end
