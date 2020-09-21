class Smartnews::Converter::Insight
  ######################################################################
  ### JSON

  JSON.mapping({
    accountId:             String?  , # "1000000"
    campaignId:            String?  , # "1000003"
    creativeId:            String?  , # "1000013"
    accountName:           String?  , # "SmartNews, Inc"
    campaignName:          String?  , # "SmartNews Installs 7/12"
    creativeName:          String?  , # "label for creative management"
    impressions:           Int64?   , # 13204
    viewableImpressions:   Int64?   , # 10444
    clicks:                Int64?   , # 48
    conversions:           Int64?   , # 3
    spend:                 Float64? , # 1052.5128
    cpm:                   Float64? , # 100.77678752999999
    cpc:                   Float64? , # 21.92734935
    ctr:                   Float64? , # 0.36353
    vctr:                  Float64? , # 0.45959
    cvr:                   Float64? , # 6.25
    cpa:                   Float64? , # 350.83758967
    videoAvgViewRate:      Float64? , # 41.20017
    videoAvgViewTime:      Float64? , # 4085.73368
    videoCompleteViewRate: Float64? , # 43.09866
    videoCompleteViews:    Int64?   , # 1861
    videoLength:           Int64?   , # 9915
    videoP100Views:        Int64?   , # 1861
    videoP25Views:         Int64?   , # 3426
    videoP50Views:         Int64?   , # 2834
    videoP75Views:         Int64?   , # 2266
    videoP95Views:         Int64?   , # 1876
    videoViewableViews:    Int64?   , # 3603
    videoViews:            Int64?   , # 4318
  })

  ######################################################################
  ### Protobuf

  def to_pb
    Smartnews::Proto::Insight.new(
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
      video_avg_view_rate: videoAvgViewRate,
      video_avg_view_time: videoAvgViewTime,
      video_complete_view_rate: videoCompleteViewRate,
      video_complete_views: videoCompleteViews,
      video_length: videoLength,
      video_p100_views: videoP100Views,
      video_p25_views: videoP25Views,
      video_p50_views: videoP50Views,
      video_p75_views: videoP75Views,
      video_p95_views: videoP95Views,
      video_viewable_views: videoViewableViews,
      video_views: videoViews,
    )
  end

  def self.protobuf_schema : ProtobufSchema::Schema
    ProtobufSchema.parse(protobuf_schema_string)
  end

  def self.protobuf_schema_string : String
    <<-EOF
      syntax = "proto2";
      
      message Insight {
        optional string accountId             = 1  ; // "1000000"
        optional string campaignId            = 2  ; // "1000003"
        optional string creativeId            = 3  ; // "1000013"
        optional string accountName           = 4  ; // "SmartNews, Inc"
        optional string campaignName          = 5  ; // "SmartNews Installs 7/12"
        optional string creativeName          = 6  ; // "label for creative management"
        optional int64  impressions           = 7  ; // 13204
        optional int64  viewableImpressions   = 8  ; // 10444
        optional int64  clicks                = 9  ; // 48
        optional int64  conversions           = 10 ; // 3
        optional double spend                 = 11 ; // 1052.5128
        optional double cpm                   = 12 ; // 100.77678752999999
        optional double cpc                   = 13 ; // 21.92734935
        optional double ctr                   = 14 ; // 0.36353
        optional double vctr                  = 15 ; // 0.45959
        optional double cvr                   = 16 ; // 6.25
        optional double cpa                   = 17 ; // 350.83758967
        optional double videoAvgViewRate      = 18 ; // 41.20017
        optional double videoAvgViewTime      = 19 ; // 4085.73368
        optional double videoCompleteViewRate = 20 ; // 43.09866
        optional int64  videoCompleteViews    = 21 ; // 1861
        optional int64  videoLength           = 22 ; // 9915
        optional int64  videoP100Views        = 23 ; // 1861
        optional int64  videoP25Views         = 24 ; // 3426
        optional int64  videoP50Views         = 25 ; // 2834
        optional int64  videoP75Views         = 26 ; // 2266
        optional int64  videoP95Views         = 27 ; // 1876
        optional int64  videoViewableViews    = 28 ; // 3603
        optional int64  videoViews            = 29 ; // 4318
      }
      
      message InsightArray {
        repeated Insight array = 1;
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
      CREATE TABLE insight (
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
        cpa Nullable(Float64),
        video_avg_view_rate Nullable(Float64),
        video_avg_view_time Nullable(Float64),
        video_complete_view_rate Nullable(Float64),
        video_complete_views Nullable(Int64),
        video_length Nullable(Int64),
        video_p100_views Nullable(Int64),
        video_p25_views Nullable(Int64),
        video_p50_views Nullable(Int64),
        video_p75_views Nullable(Int64),
        video_p95_views Nullable(Int64),
        video_viewable_views Nullable(Int64),
        video_views Nullable(Int64)
      )
      ENGINE = Log
      EOF
  end
end
