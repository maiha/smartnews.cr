class Smartnews::Converter::Account
  ######################################################################
  ### JSON

  JSON.mapping({
    accountId: String? , # "1000000"
    name:      String? , # "SmartNews, Inc"
  })

  ######################################################################
  ### Protobuf

  def to_pb
    Smartnews::Proto::Account.new(
      account_id: accountId,
      name: name,
    )
  end

  def self.protobuf_schema : ProtobufSchema::Schema
    ProtobufSchema.parse(protobuf_schema_string)
  end

  def self.protobuf_schema_string : String
    <<-EOF
      syntax = "proto2";
      
      message Account {
        optional string accountId = 1 ; // "1000000"
        optional string name      = 2 ; // "SmartNews, Inc"
      }
      
      message AccountArray {
        repeated Account array = 1;
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
      CREATE TABLE account (
        account_id Nullable(String),
        name Nullable(String)
      )
      ENGINE = Log
      EOF
  end
end
