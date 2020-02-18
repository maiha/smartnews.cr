## Generated from smartnews/insight.proto
require "protobuf"

module Smartnews
  module Proto
    
    struct Insight
      include Protobuf::Message
      
      contract_of "proto2" do
        optional :account_id, :string, 1
        optional :campaign_id, :string, 2
        optional :creative_id, :string, 3
        optional :account_name, :string, 4
        optional :campaign_name, :string, 5
        optional :creative_name, :string, 6
        optional :impressions, :int64, 7
        optional :viewable_impressions, :int64, 8
        optional :clicks, :int64, 9
        optional :conversions, :int64, 10
        optional :spend, :double, 11
        optional :cpm, :double, 12
        optional :cpc, :double, 13
        optional :ctr, :double, 14
        optional :vctr, :double, 15
        optional :cvr, :double, 16
        optional :cpa, :double, 17
      end
    end
    
    struct InsightArray
      include Protobuf::Message
      
      contract_of "proto2" do
        repeated :array, Insight, 1
      end
    end
    end
  end
