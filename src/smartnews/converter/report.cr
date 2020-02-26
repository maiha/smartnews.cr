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
    actionType:          String?  , # "WEBSITE_CONVERSION"
    enable:              Bool?    , # true
    startTime:           String?  , # "2019-09-17T15:00:00Z"
    endTime:             String?  , # "2020-02-29T14:59:00Z"
    totalBudget:         Int64?   , # 1026473
    dailyBudget:         Int64?   , # 4116
    bidAmount:           Int64?   , # 50
    billingEvent:        String?  , # "CLICKS"
    isAutoBid:           Bool?    , # true
    sponsoredName:       String?  , # "SmartAds"
    targetCpa:           Int64?   , # 0
    status:              String?  , # "NORMAL"
    approvalStatus:      String?  , # "APPROVED"
    updatedAt:           String?  , # "2020-01-31T02:02:03Z"
    adcreativeId:        String?  , # "10000005"
    creativeType:        String?  , # "IMAGE"
    isDynamicCreative:   Bool?    , # false
    immutable:           Bool?    , # true
    title:               String?  , # "Trending News & Stories"
    text:                String?  , # "Your news in one minute."
    linkUrl:             String?  , # "http://creative.smartnews-ads.com"
    trackingUrl:         String?  , # "http://foo.trackingsystem.com/?a=b&c=d&e=f"
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
      action_type: actionType,
      enable: enable,
      start_time: startTime,
      end_time: endTime,
      total_budget: totalBudget,
      daily_budget: dailyBudget,
      bid_amount: bidAmount,
      billing_event: billingEvent,
      is_auto_bid: isAutoBid,
      sponsored_name: sponsoredName,
      target_cpa: targetCpa,
      status: status,
      approval_status: approvalStatus,
      updated_at: updatedAt,
      adcreative_id: adcreativeId,
      creative_type: creativeType,
      is_dynamic_creative: isDynamicCreative,
      immutable: immutable,
      title: title,
      text: text,
      link_url: linkUrl,
      tracking_url: trackingUrl,
    )
  end

  def self.protobuf_schema : ProtobufSchema::Schema
    ProtobufSchema.parse(protobuf_schema_string)
  end

  def self.protobuf_schema_string : String
    <<-EOF
      syntax = "proto2";
      
      message Report {
        required string date                =  1; // "2019-12-31"
      
        // insight
        optional string accountId           =  2; // "1000000"
        optional string campaignId          =  3; // "1000003"
        optional string creativeId          =  4; // "1000013"
        optional string accountName         =  5; // "SmartNews, Inc"
        optional string campaignName        =  6; // "SmartNews Installs 7/12"
        optional string creativeName        =  7; // "label for creative management"
        optional int64  impressions         =  8; // 13204
        optional int64  viewableImpressions =  9; // 10444
        optional int64  clicks              = 10; // 48
        optional int64  conversions         = 11; // 3
        optional double spend               = 12; // 1052.5128
        optional double cpm                 = 13; // 100.77678752999999
        optional double cpc                 = 14; // 21.92734935
        optional double ctr                 = 15; // 0.36353
        optional double vctr                = 16; // 0.45959
        optional double cvr                 = 17; // 6.25
        optional double cpa                 = 18; // 350.83758967
      
        // campaign
        optional string actionType     = 19; // "WEBSITE_CONVERSION"
        optional bool   enable         = 20; // true
        optional string startTime      = 21; // "2019-09-17T15:00:00Z"
        optional string endTime        = 22; // "2020-02-29T14:59:00Z"
        optional int64  totalBudget    = 23; // 1026473
        optional int64  dailyBudget    = 24; // 4116
        optional int64  bidAmount      = 25; // 50
        optional string billingEvent   = 26; // "CLICKS"
        optional bool   isAutoBid      = 27; // true
        optional string sponsoredName  = 28; // "SmartAds"
        optional int64  targetCpa      = 29; // 0
        optional string status         = 30; // "NORMAL"
        optional string approvalStatus = 31; // "APPROVED"
        optional string updatedAt      = 32; // "2020-01-31T02:02:03Z"
      
        // creative
        optional string adcreativeId      = 33; // "10000005"
        optional string creativeType      = 34; // "IMAGE"
        optional bool   isDynamicCreative = 35; // false
        optional bool   immutable         = 36; // true
        optional string title             = 37; // "Trending News & Stories"
        optional string text              = 38; // "Your news in one minute."
        optional string linkUrl           = 39; // "http://creative.smartnews-ads.com"
        optional string trackingUrl       = 40; //  "http://foo.trackingsystem.com/?a=b&c=d&e=f"
      }
      
      message ReportArray {
        repeated Report array =  1; 
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
        cpa Nullable(Float64),
        action_type Nullable(String),
        enable Nullable(UInt8),
        start_time Nullable(String),
        end_time Nullable(String),
        total_budget Nullable(Int64),
        daily_budget Nullable(Int64),
        bid_amount Nullable(Int64),
        billing_event Nullable(String),
        is_auto_bid Nullable(UInt8),
        sponsored_name Nullable(String),
        target_cpa Nullable(Int64),
        status Nullable(String),
        approval_status Nullable(String),
        updated_at Nullable(String),
        adcreative_id Nullable(String),
        creative_type Nullable(String),
        is_dynamic_creative Nullable(UInt8),
        immutable Nullable(UInt8),
        title Nullable(String),
        text Nullable(String),
        link_url Nullable(String),
        tracking_url Nullable(String)
      )
      ENGINE = Log
      EOF
  end
end
