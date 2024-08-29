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
        optional :view_content, :int64, 57
        optional :purchase, :int64, 58
        optional :add_to_cart, :int64, 59
        optional :complete_registration, :int64, 60
        optional :subscribe, :int64, 61
        optional :amv2_campaign_id, :string, 62
        optional :amv2_campaign_name, :string, 63
        optional :amv2_ad_group_id, :string, 64
        optional :amv2_ad_group_name, :string, 65
        optional :amv2_campaign_spending_limit, :int64, 66
        optional :amv2_campaign_daily_budget, :int64, 67
        optional :amv2_is_migrated_from_v1, :bool, 68
        optional :amv2_add_to_cart, :int64, 69
        optional :amv2_purchase, :int64, 70
        optional :amv2_subscribe, :int64, 71
        optional :amv2_complete_registration, :int64, 72
        optional :amv2_view_content, :int64, 73
        optional :amv2_add_to_cart_cpa, :double, 74
        optional :amv2_add_to_cart_cvr, :double, 75
        optional :amv2_purchase_cpa, :double, 76
        optional :amv2_purchase_cvr, :double, 77
        optional :amv2_subscribe_cpa, :double, 78
        optional :amv2_subscribe_cvr, :double, 79
        optional :amv2_complete_registration_cpa, :double, 80
        optional :amv2_complete_registration_cvr, :double, 81
        optional :amv2_view_content_cpa, :double, 82
        optional :amv2_view_content_cvr, :double, 83
        optional :amv2_initiate_checkout, :int64, 84
        optional :amv2_initiate_checkout_cpa, :double, 85
        optional :amv2_initiate_checkout_cvr, :double, 86
        optional :amv2_submit_form, :int64, 87
        optional :amv2_submit_form_cpa, :double, 88
        optional :amv2_submit_form_cvr, :double, 89
        optional :amv2_contact, :int64, 90
        optional :amv2_contact_cpa, :double, 91
        optional :amv2_contact_cpr, :double, 92
        optional :amv2_sign_up, :int64, 93
        optional :amv2_sign_up_cpa, :double, 94
        optional :amv2_sign_up_cpr, :double, 95
        optional :amv2_add_payment_info, :int64, 96
        optional :amv2_add_payment_info_cpa, :double, 97
        optional :amv2_add_payment_info_cpr, :double, 98
        optional :amv2_add_to_wish_list, :int64, 99
        optional :amv2_add_to_wish_list_cpa, :double, 100
        optional :amv2_add_to_wish_list_cpr, :double, 101
        optional :amv2_visit_cart, :int64, 102
        optional :amv2_visit_cart_cpa, :double, 103
        optional :amv2_visit_cart_cpr, :double, 104
        optional :amv2_customize_product, :int64, 105
        optional :amv2_customize_product_cpa, :double, 106
        optional :amv2_customize_product_cpr, :double, 107
        optional :amv2_search, :int64, 108
        optional :amv2_search_cpa, :double, 109
        optional :amv2_search_cpr, :double, 110
        optional :amv2_booking, :int64, 111
        optional :amv2_booking_cpa, :double, 112
        optional :amv2_booking_cpr, :double, 113
        optional :amv2_download, :int64, 114
        optional :amv2_download_cpa, :double, 115
        optional :amv2_download_cpr, :double, 116
        optional :amv2_start_trial, :int64, 117
        optional :amv2_start_trial_cpa, :double, 118
        optional :amv2_start_trial_cpr, :double, 119
        optional :amv2_share, :int64, 120
        optional :amv2_share_cpa, :double, 121
        optional :amv2_share_cpr, :double, 122
        optional :amv2_login, :int64, 123
        optional :amv2_login_cpa, :double, 124
        optional :amv2_login_cpr, :double, 125
        optional :amv2_donate, :int64, 126
        optional :amv2_donate_cpa, :double, 127
        optional :amv2_donate_cpr, :double, 128
        optional :amv2_find_location, :int64, 129
        optional :amv2_find_location_cpa, :double, 130
        optional :amv2_find_location_cpr, :double, 131
        optional :amv2_time_spent, :int64, 132
        optional :amv2_time_spent_cpa, :double, 133
        optional :amv2_time_spent_cpr, :double, 134
        optional :amv2_install, :int64, 135
        optional :amv2_install_cpa, :double, 136
        optional :amv2_install_cpr, :double, 137
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
