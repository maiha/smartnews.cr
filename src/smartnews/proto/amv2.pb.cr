## Generated from amv2.proto
require "protobuf"

module Smartnews
  module Proto
    
    struct Amv2
      include ::Protobuf::Message
      
      contract_of "proto2" do
        optional :campaign_id, :string, 1
        optional :campaign_name, :string, 2
        optional :ad_group_id, :string, 3
        optional :ad_group_name, :string, 4
        optional :campaign_spending_limit, :int64, 5
        optional :campaign_daily_budget, :int64, 6
      end
    end
    
    struct Amv2Array
      include ::Protobuf::Message
      
      contract_of "proto2" do
        repeated :array, Amv2, 1
      end
    end
    end
  end
