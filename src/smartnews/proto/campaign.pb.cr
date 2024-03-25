## Generated from smartnews/campaign.proto
require "protobuf"

require "./amv2.pb.cr"

module Smartnews
  module Proto
    
    struct Campaign
      include ::Protobuf::Message
      
      contract_of "proto2" do
        optional :action_type, :string, 1
        optional :name, :string, 2
        optional :campaign_id, :string, 3
        optional :account_id, :string, 4
        optional :enable, :bool, 5
        optional :start_time, :string, 6
        optional :end_time, :string, 7
        optional :total_budget, :int64, 8
        optional :daily_budget, :int64, 9
        optional :bid_amount, :int64, 10
        optional :billing_event, :string, 11
        optional :is_auto_bid, :bool, 12
        optional :sponsored_name, :string, 13
        optional :target_cpa, :int64, 14
        optional :creative_type, :string, 15
        optional :status, :string, 16
        optional :approval_status, :string, 17
        optional :updated_at, :string, 18
        optional :amv2, Amv2, 19
      end
    end
    
    struct CampaignArray
      include ::Protobuf::Message
      
      contract_of "proto2" do
        repeated :array, Campaign, 1
      end
    end
    end
  end
