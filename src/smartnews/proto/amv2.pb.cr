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
        optional :is_migrated_from_v1, :bool, 7
        optional :add_to_cart, :int64, 8
        optional :purchase, :int64, 9
        optional :subscribe, :int64, 10
        optional :complete_registration, :int64, 11
        optional :view_content, :int64, 12
        optional :add_to_cart_cpa, :double, 13
        optional :add_to_cart_cvr, :double, 14
        optional :purchase_cpa, :double, 15
        optional :purchase_cvr, :double, 16
        optional :subscribe_cpa, :double, 17
        optional :subscribe_cvr, :double, 18
        optional :complete_registration_cpa, :double, 19
        optional :complete_registration_cvr, :double, 20
        optional :view_content_cpa, :double, 21
        optional :view_content_cvr, :double, 22
        optional :initiate_checkout, :int64, 23
        optional :initiate_checkout_cpa, :double, 24
        optional :initiate_checkout_cvr, :double, 25
        optional :submit_form, :int64, 26
        optional :submit_form_cpa, :double, 27
        optional :submit_form_cvr, :double, 28
        optional :contact, :int64, 29
        optional :contact_cpa, :double, 30
        optional :contact_cvr, :double, 31
        optional :sign_up, :int64, 32
        optional :sign_up_cpa, :double, 33
        optional :sign_up_cvr, :double, 34
        optional :add_payment_info, :int64, 35
        optional :add_payment_info_cpa, :double, 36
        optional :add_payment_info_cvr, :double, 37
        optional :add_to_wish_list, :int64, 38
        optional :add_to_wish_list_cpa, :double, 39
        optional :add_to_wish_list_cvr, :double, 40
        optional :visit_cart, :int64, 41
        optional :visit_cart_cpa, :double, 42
        optional :visit_cart_cvr, :double, 43
        optional :customize_product, :int64, 44
        optional :customize_product_cpa, :double, 45
        optional :customize_product_cvr, :double, 46
        optional :search, :int64, 47
        optional :search_cpa, :double, 48
        optional :search_cvr, :double, 49
        optional :booking, :int64, 50
        optional :booking_cpa, :double, 51
        optional :booking_cvr, :double, 52
        optional :download, :int64, 53
        optional :download_cpa, :double, 54
        optional :download_cvr, :double, 55
        optional :start_trial, :int64, 56
        optional :start_trial_cpa, :double, 57
        optional :start_trial_cvr, :double, 58
        optional :share, :int64, 59
        optional :share_cpa, :double, 60
        optional :share_cvr, :double, 61
        optional :login, :int64, 62
        optional :login_cpa, :double, 63
        optional :login_cvr, :double, 64
        optional :donate, :int64, 65
        optional :donate_cpa, :double, 66
        optional :donate_cvr, :double, 67
        optional :find_location, :int64, 68
        optional :find_location_cpa, :double, 69
        optional :find_location_cvr, :double, 70
        optional :time_spent, :int64, 71
        optional :time_spent_cpa, :double, 72
        optional :time_spent_cvr, :double, 73
        optional :install, :int64, 74
        optional :install_cpa, :double, 75
        optional :install_cvr, :double, 76
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
