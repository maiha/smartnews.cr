class Smartnews::Converter::Campaign
  ######################################################################
  ### JSON

  JSON.mapping({
    actionType:     String? , # "WEBSITE_CONVERSION"
    name:           String? , # "SmartNews Installs 7/12"
    campaignId:     String? , # "1000005"
    accountId:      String? , # "1000000"
    enable:         Bool?   , # true
    startTime:      String? , # "2019-09-17T15:00:00Z"
    endTime:        String? , # "2020-02-29T14:59:00Z"
    totalBudget:    Int64?  , # 1026473
    dailyBudget:    Int64?  , # 4116
    bidAmount:      Int64?  , # 50
    billingEvent:   String? , # "CLICKS"
    isAutoBid:      Bool?   , # true
    sponsoredName:  String? , # "SmartAds"
    targetCpa:      Int64?  , # 0
    creativeType:   String? , # "IMAGE"
    status:         String? , # "NORMAL"
    approvalStatus: String? , # "APPROVED"
    updatedAt:      String? , # "2020-01-31T02:02:03Z"
    amv2:           Smartnews::Proto::Amv2? , #
  })

  ######################################################################
  ### Protobuf

  def to_pb
    Smartnews::Proto::Campaign.new(
      action_type: actionType,
      name: name,
      campaign_id: campaignId,
      account_id: accountId,
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
      creative_type: creativeType,
      status: status,
      approval_status: approvalStatus,
      updated_at: updatedAt,
      amv2: amv2,
    )
  end

  def self.protobuf_schema : ProtobufSchema::Schema
    ProtobufSchema.parse(protobuf_schema_string)
  end

  def self.protobuf_schema_string : String
    <<-EOF
      syntax = "proto2";
      
      import "amv2.proto";
      
      message Campaign {
        optional string actionType     = 1  ; // "WEBSITE_CONVERSION"
        optional string name           = 2  ; // "SmartNews Installs 7/12"
        optional string campaignId     = 3  ; // "1000005"
        optional string accountId      = 4  ; // "1000000"
        optional bool   enable         = 5  ; // true
        optional string startTime      = 6  ; // "2019-09-17T15:00:00Z"
        optional string endTime        = 7  ; // "2020-02-29T14:59:00Z"
        optional int64  totalBudget    = 8  ; // 1026473
        optional int64  dailyBudget    = 9  ; // 4116
        optional int64  bidAmount      = 10 ; // 50
        optional string billingEvent   = 11 ; // "CLICKS"
        optional bool   isAutoBid      = 12 ; // true
        optional string sponsoredName  = 13 ; // "SmartAds"
        optional int64  targetCpa      = 14 ; // 0
        optional string creativeType   = 15 ; // "IMAGE"
        optional string status         = 16 ; // "NORMAL"
        optional string approvalStatus = 17 ; // "APPROVED"
        optional string updatedAt      = 18 ; // "2020-01-31T02:02:03Z"
        optional Amv2   amv2           = 19 ; 
      }
      
      message CampaignArray {
        repeated Campaign array = 1;
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
      CREATE TABLE campaign (
        action_type Nullable(String),
        name Nullable(String),
        campaign_id Nullable(String),
        account_id Nullable(String),
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
        creative_type Nullable(String),
        status Nullable(String),
        approval_status Nullable(String),
        updated_at Nullable(String),
        amv2 Nullable(String)
      )
      ENGINE = Log
      EOF
  end
end
