## Generated from smartnews/report.proto
require "protobuf"

module Smartnews
  module Proto
    
    struct Report
      include Protobuf::Message
      
      contract_of "proto2" do
        required :date, :string, 1
        optional :account_id, :string, 2
        optional :campaign_id, :string, 3
        optional :creative_id, :string, 4
        optional :account_name, :string, 5
        optional :campaign_name, :string, 6
        optional :creative_name, :string, 7
        optional :impressions, :int64, 8
        optional :viewable_impressions, :int64, 9
        optional :clicks, :int64, 10
        optional :conversions, :int64, 11
        optional :spend, :double, 12
        optional :cpm, :double, 13
        optional :cpc, :double, 14
        optional :ctr, :double, 15
        optional :vctr, :double, 16
        optional :cvr, :double, 17
        optional :cpa, :double, 18
      end
    end
    
    struct ReportArray
      include Protobuf::Message
      
      contract_of "proto2" do
        repeated :array, Report, 1
      end
    end
    end
  end
