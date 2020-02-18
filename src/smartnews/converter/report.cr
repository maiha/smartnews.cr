class Smartnews::Converter::Report
  ######################################################################
  ### JSON

  JSON.mapping({
    date:                String   , # "2019-12-31"
    accountId:           String?  , # "1000000"
    campaignId:          String?  , # "1000003"
    creativeId:          String?  , # "1000013"
    accountName:         String?  , # "SmartNews, Inc"
    campaignName:        String?  , # "SmartNews Installs 7/12"
    creativeName:        String?  , # "label for creative management"
    impressions:         Int64?   , # 13204
    viewableImpressions: Int64?   , # 10444
    clicks:              Int64?   , # 48
    conversions:         Int64?   , # 3
    spend:               Float64? , # 1052.5128
    cpm:                 Float64? , # 100.77678752999999
    cpc:                 Float64? , # 21.92734935
    ctr:                 Float64? , # 0.36353
    vctr:                Float64? , # 0.45959
    cvr:                 Float64? , # 6.25
    cpa:                 Float64? , # 350.83758967
  })

  ######################################################################
  ### Protobuf

  def to_pb
    Smartnews::Proto::Report.new(
      date: date,
      account_id: accountId,
      campaign_id: campaignId,
      creative_id: creativeId,
      account_name: accountName,
      campaign_name: campaignName,
      creative_name: creativeName,
      impressions: impressions,
      viewable_impressions: viewableImpressions,
      clicks: clicks,
      conversions: conversions,
      spend: spend,
      cpm: cpm,
      cpc: cpc,
      ctr: ctr,
      vctr: vctr,
      cvr: cvr,
      cpa: cpa,
    )
  end

  def self.protobuf_schema : ProtobufSchema::Schema
    ProtobufSchema.parse(protobuf_schema_string)
  end

  def self.protobuf_schema_string : String
    <<-EOF
      syntax = "proto2";
      
      message Report {
        required string date                = 1  ; // "2019-12-31"
        optional string accountId           = 2  ; // "1000000"
        optional string campaignId          = 3  ; // "1000003"
        optional string creativeId          = 4  ; // "1000013"
        optional string accountName         = 5  ; // "SmartNews, Inc"
        optional string campaignName        = 6  ; // "SmartNews Installs 7/12"
        optional string creativeName        = 7  ; // "label for creative management"
        optional int64  impressions         = 8  ; // 13204
        optional int64  viewableImpressions = 9  ; // 10444
        optional int64  clicks              = 10 ; // 48
        optional int64  conversions         = 11 ; // 3
        optional double spend               = 12 ; // 1052.5128
        optional double cpm                 = 13 ; // 100.77678752999999
        optional double cpc                 = 14 ; // 21.92734935
        optional double ctr                 = 15 ; // 0.36353
        optional double vctr                = 16 ; // 0.45959
        optional double cvr                 = 17 ; // 6.25
        optional double cpa                 = 18 ; // 350.83758967
      }
      
      message ReportArray {
        repeated Report array = 1;
      }
      EOF
  end

  ######################################################################
  ### ClickHouse

  def self.clickhouse_create : Clickhouse::Schema::Create
    Clickhouse::Schema::Create.parse(clickhouse_schema_sql)
  end

  def self.clickhouse_schema_sql
    <<-EOF
      CREATE TABLE report (
        date String,
        account_id Nullable(String),
        campaign_id Nullable(String),
        creative_id Nullable(String),
        account_name Nullable(String),
        campaign_name Nullable(String),
        creative_name Nullable(String),
        impressions Nullable(Int64),
        viewable_impressions Nullable(Int64),
        clicks Nullable(Int64),
        conversions Nullable(Int64),
        spend Nullable(Float64),
        cpm Nullable(Float64),
        cpc Nullable(Float64),
        ctr Nullable(Float64),
        vctr Nullable(Float64),
        cvr Nullable(Float64),
        cpa Nullable(Float64)
      )
      ENGINE = Log
      EOF
  end
end
