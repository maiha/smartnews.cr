## Generated from smartnews/insight.proto
require "protobuf"

module Smartnews
  module Proto
    
    struct Insight
      include ::Protobuf::Message
      
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
        optional :video_avg_view_rate, :double, 18
        optional :video_avg_view_time, :double, 19
        optional :video_complete_view_rate, :double, 20
        optional :video_complete_views, :int64, 21
        optional :video_length, :int64, 22
        optional :video_p100_views, :int64, 23
        optional :video_p25_views, :int64, 24
        optional :video_p50_views, :int64, 25
        optional :video_p75_views, :int64, 26
        optional :video_p95_views, :int64, 27
        optional :video_viewable_views, :int64, 28
        optional :video_views, :int64, 29
      end
    end
    
    struct InsightArray
      include ::Protobuf::Message
      
      contract_of "proto2" do
        repeated :array, Insight, 1
      end
    end
    end
  end
