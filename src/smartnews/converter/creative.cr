#class Imageinfo
#  JSON.mapping(      
#    imageId:         String? ,
#    imageUrl:        String? ,
#    width:           Int32?  ,
#    height:          Int32?  ,
#  )
#end

class Smartnews::Converter::Creative
  
  ######################################################################
  ### JSON

  class Imageinfo
    JSON.mapping(
      imageId:         String? ,
      imageUrl:        String? ,
      width:           Int32?  ,
      height:          Int32?  ,
    )
  end

  JSON.mapping({
    adcreativeId:      String? , # "10000005"
    accountId:         String? , # "10000002"
    name:              String? , # "label for creative management"
    creativeType:      String? , # "IMAGE"
    isDynamicCreative: Bool?   , # false
    immutable:         Bool?   , # true
    title:             String? , # "Trending News & Stories"
    text:              String? , # "Your news in one minute."
    sponsoredName:     String? , # "smartnews"
    creativeId:        String? , # "1000020"
    campaignId:        String? , # "1000021"
    enable:            Bool?   , # true
    status:            String? , # "NORMAL"
    approvalStatus:    String? , # "APPROVED"
    linkUrl:           String? , # "http://creative.smartnews-ads.com"
    trackingUrl:       String? , # "http://foo.trackingsystem.com/?a=b&c=d&e=f"
    imageset:          {type: Hash(String, Imageinfo), nilable: true},
  })

  ######################################################################
  ### Protobuf

  def to_pb
    Smartnews::Proto::Creative.new(
      adcreative_id: adcreativeId,
      account_id: accountId,
      name: name,
      creative_type: creativeType,
      is_dynamic_creative: isDynamicCreative,
      immutable: immutable,
      title: title,
      text: text,
      sponsored_name: sponsoredName,
      creative_id: creativeId,
      campaign_id: campaignId,
      enable: enable,
      status: status,
      approval_status: approvalStatus,
      link_url: linkUrl,
      tracking_url: trackingUrl,
      imageset: imageset,
    )
  end

  def self.protobuf_schema : ProtobufSchema::Schema
    ProtobufSchema.parse(protobuf_schema_string)
  end

  def self.protobuf_schema_string : String
    <<-EOF
      syntax = "proto2";
      
      message Creative {
        optional string adcreativeId      = 1  ; // "10000005"
        optional string accountId         = 2  ; // "10000002"
        optional string name              = 3  ; // "label for creative management"
        optional string creativeType      = 4  ; // "IMAGE"
        optional bool   isDynamicCreative = 5  ; // false
        optional bool   immutable         = 6  ; // true
        optional string title             = 7  ; // "Trending News & Stories"
        optional string text              = 8  ; // "Your news in one minute."
        optional string sponsoredName     = 9  ; // "smartnews"
        optional string creativeId        = 10 ; // "1000020"
        optional string campaignId        = 11 ; // "1000021"
        optional bool   enable            = 12 ; // true
        optional string status            = 13 ; // "NORMAL"
        optional string approvalStatus    = 14 ; // "APPROVED"
        optional string linkUrl           = 15 ; // "http://creative.smartnews-ads.com"
        optional string trackingUrl       = 16 ; //  "http://foo.trackingsystem.com/?a=b&c=d&e=f"
        optional string imageId           = 17 ;
      }
      
      message CreativeArray {
        repeated Creative array = 1;
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
      CREATE TABLE creative (
        adcreative_id Nullable(String),
        account_id Nullable(String),
        name Nullable(String),
        creative_type Nullable(String),
        is_dynamic_creative Nullable(UInt8),
        immutable Nullable(UInt8),
        title Nullable(String),
        text Nullable(String),
        sponsored_name Nullable(String),
        creative_id Nullable(String),
        campaign_id Nullable(String),
        enable Nullable(UInt8),
        status Nullable(String),
        approval_status Nullable(String),
        link_url Nullable(String),
        tracking_url Nullable(String)
      )
      ENGINE = Log
      EOF
  end
end
