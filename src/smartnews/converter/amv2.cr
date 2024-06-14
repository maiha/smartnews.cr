class Smartnews::Converter::Amv2
  ######################################################################
  ### JSON

  JSON.mapping({
    campaignId:            String? , # "1000004"
    campaignName:          String? , # "test"
    adGroupId:             String? , # "1000003"
    adGroupName:           String? , # "test"
    campaignSpendingLimit: Int64?  , # 100
    campaignDailyBudget:   Int64?  , # 100
  })

  ######################################################################
  ### Protobuf

  def to_pb
    Smartnews::Proto::Amv2.new(
      campaign_id: campaignId,
      campaign_name: campaignName,
      ad_group_id: adGroupId,
      ad_group_name: adGroupName,
      campaign_spending_limit: campaignSpendingLimit,
      campaign_daily_budget: campaignDailyBudget,
    )
  end

  def self.protobuf_schema : ProtobufSchema::Schema
    ProtobufSchema.parse(protobuf_schema_string)
  end

  def self.protobuf_schema_string : String
    <<-EOF
      syntax = "proto2";
      
      message Amv2 {
        optional string campaignId            = 1; // "1000004"
        optional string campaignName          = 2; // "test"
        optional string adGroupId             = 3; // "1000003"
        optional string adGroupName           = 4; // "test"
        optional int64  campaignSpendingLimit = 5; // 100
        optional int64  campaignDailyBudget   = 6; // 100
      }
      
      message Amv2Array {
        repeated Amv2 array = 1;
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
      CREATE TABLE amv2 (
        campaign_id Nullable(String),
        campaign_name Nullable(String),
        ad_group_id Nullable(String),
        ad_group_name Nullable(String),
        campaign_spending_limit Nullable(Int64),
        campaign_daily_budget Nullable(Int64)
      )
      ENGINE = Log
      EOF
  end
end
