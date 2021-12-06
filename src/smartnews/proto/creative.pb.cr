## Generated from smartnews/creative.proto
require "protobuf"

module Smartnews
  module Proto
    
    struct Imageinfo
      include ::Protobuf::Message
      
      contract_of "proto2" do
        optional :image_id, :string, 1
        optional :image_url, :string, 2
        optional :width, :string, 3
        optional :height, :string, 4
      end
    end
    
    struct Creative
      include ::Protobuf::Message
      
      contract_of "proto2" do
        optional :adcreative_id, :string, 1
        optional :account_id, :string, 2
        optional :name, :string, 3
        optional :creative_type, :string, 4
        optional :is_dynamic_creative, :bool, 5
        optional :immutable, :bool, 6
        optional :title, :string, 7
        optional :text, :string, 8
        optional :sponsored_name, :string, 9
        optional :creative_id, :string, 10
        optional :campaign_id, :string, 11
        optional :enable, :bool, 12
        optional :status, :string, 13
        optional :approval_status, :string, 14
        optional :link_url, :string, 15
        optional :tracking_url, :string, 16
        repeated :imageinfo, Imageinfo, 17
      end
    end
    
    struct CreativeArray
      include ::Protobuf::Message
      
      contract_of "proto2" do
        repeated :array, Creative, 1
      end
    end
    end
  end
