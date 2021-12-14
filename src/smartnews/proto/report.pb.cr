## Generated from smartnews/report.proto
require "protobuf"

module Smartnews
  module Proto
    
    struct Report
      include ::Protobuf::Message
      
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
        optional :action_type, :string, 19
        optional :enable, :bool, 20
        optional :start_time, :string, 21
        optional :end_time, :string, 22
        optional :total_budget, :int64, 23
        optional :daily_budget, :int64, 24
        optional :bid_amount, :int64, 25
        optional :billing_event, :string, 26
        optional :is_auto_bid, :bool, 27
        optional :sponsored_name, :string, 28
        optional :target_cpa, :int64, 29
        optional :status, :string, 30
        optional :approval_status, :string, 31
        optional :updated_at, :string, 32
        optional :adcreative_id, :string, 33
        optional :creative_type, :string, 34
        optional :is_dynamic_creative, :bool, 35
        optional :immutable, :bool, 36
        optional :title, :string, 37
        optional :text, :string, 38
        optional :link_url, :string, 39
        optional :tracking_url, :string, 40
        optional :video_avg_view_rate, :double, 41
        optional :video_avg_view_time, :double, 42
        optional :video_complete_view_rate, :double, 43
        optional :video_complete_views, :int64, 44
        optional :video_length, :int64, 45
        optional :video_p100_views, :int64, 46
        optional :video_p25_views, :int64, 47
        optional :video_p50_views, :int64, 48
        optional :video_p75_views, :int64, 49
        optional :video_p95_views, :int64, 50
        optional :video_viewable_views, :int64, 51
        optional :video_views, :int64, 52
        optional :image_id, :string, 53
        optional :image_url, :string, 54
        optional :width, :int64, 55
        optional :height, :int64, 56
      end
    end
    
    struct ReportArray
      include ::Protobuf::Message
      
      contract_of "proto2" do
        repeated :array, Report, 1
      end
    end
    end
  end
