## Generated from smartnews/account.proto
require "protobuf"

module Smartnews
  module Proto
    
    struct Account
      include Protobuf::Message
      
      contract_of "proto2" do
        optional :account_id, :string, 1
        optional :name, :string, 2
      end
    end
    
    struct AccountArray
      include Protobuf::Message
      
      contract_of "proto2" do
        repeated :array, Account, 1
      end
    end
    end
  end
