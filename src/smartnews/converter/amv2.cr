class Smartnews::Converter::Amv2
  ######################################################################
  ### JSON

  JSON.mapping({
    campaignId:            String? , # "1000004"
    campaignName:          String? , # "test"
    adGroupId:             String? , # "1000003"
    adGroupName:           String? , # "test"
    campaignSpendingLimit: Int64?  , # 100
    campaignDailyBudget:   Int64?  , # 100
    isMigratedFromV1:      Bool?   ,
    addToCart:             Int64?  ,
    purchase:              Int64?  ,
    subscribe:             Int64?  ,
    completeRegistration:  Int64?  ,
    viewContent:           Int64?  ,
    addToCartCpa:          Float64?  ,
    addToCartCvr:          Float64?  ,
    purchaseCpa:           Float64?  ,
    purchaseCvr:           Float64?  ,
    subscribeCpa:          Float64?  ,
    subscribeCvr:          Float64?  ,
    completeRegistrationCpa: Float64?  ,
    completeRegistrationCvr: Float64?  ,
    viewContentCpa:        Float64?  ,
    viewContentCvr:        Float64?  ,
    initiateCheckout:      Int64?  ,
    initiateCheckoutCpa:   Float64?  ,
    initiateCheckoutCvr:   Float64?  ,
    submitForm:            Int64?  ,
    submitFormCpa:         Float64?  ,
    submitFormCvr:         Float64?  ,
    contact:               Int64?  ,
    contactCpa:            Float64?  ,
    contactCvr:            Float64?  ,
    signUp:                Int64?  ,
    signUpCpa:             Float64?  ,
    signUpCvr:             Float64?  ,
    addPaymentInfo:        Int64?  ,
    addPaymentInfoCpa:     Float64?  ,
    addPaymentInfoCvr:     Float64?  ,
    addToWishList:         Int64?  ,
    addToWishListCpa:      Float64?  ,
    addToWishListCvr:      Float64?  ,
    visitCart:             Int64?  ,
    visitCartCpa:          Float64?  ,
    visitCartCvr:          Float64?  ,
    customizeProduct:      Int64?  ,
    customizeProductCpa:   Float64?  ,
    customizeProductCvr:   Float64?  ,
    search:                Int64?  ,
    searchCpa:             Float64?  ,
    searchCvr:             Float64?  ,
    booking:               Int64?  ,
    bookingCpa:            Float64?  ,
    bookingCvr:            Float64?  ,
    download:              Int64?  ,
    downloadCpa:           Float64?  ,
    downloadCvr:           Float64?  ,
    startTrial:            Int64?  ,
    startTrialCpa:         Float64?  ,
    startTrialCvr:         Float64?  ,
    share:                 Int64?  ,
    shareCpa:              Float64?  ,
    shareCvr:              Float64?  ,
    login:                 Int64?  ,
    loginCpa:              Float64?  ,
    loginCvr:              Float64?  ,
    donate:                Int64?  ,
    donateCpa:             Float64?  ,
    donateCvr:             Float64?  ,
    findLocation:          Int64?  ,
    findLocationCpa:       Float64?  ,
    findLocationCvr:       Float64?  ,
    timeSpent:             Int64?  ,
    timeSpentCpa:          Float64?  ,
    timeSpentCvr:          Float64?  ,
    install:               Int64?  ,
    installCpa:            Float64?  ,
    installCvr:            Float64?  ,
  })

  ######################################################################
  ### Protobuf

  def to_pb
    Smartnews::Proto::Amv2.new(
      campaign_id: campaignId,
      campaign_name: campaignName,
      ad_group_id: adGroupId,
      ad_group_name: adGroupName,
      campaign_spending_limit: campaignSpendingLimit,
      campaign_daily_budget: campaignDailyBudget,
      is_migrated_from_v1: isMigratedFromV1,
      add_to_cart: addToCart,
      purchase: purchase,
      subscribe: subscribe,
      complete_registration: completeRegistration,
      view_content: viewContent,
      add_to_cart_cpa: addToCartCpa,
      add_to_cart_cvr: addToCartCvr,
      purchase_cpa: purchaseCpa,
      purchase_cvr: purchaseCvr,
      subscribe_cpa: subscribeCpa,
      subscribe_cvr: subscribeCvr,
      complete_registration_cpa: completeRegistrationCpa,
      complete_registration_cvr: completeRegistrationCvr,
      view_content_cpa: viewContentCpa,
      view_content_cvr: viewContentCvr,
      initiate_checkout: initiateCheckout,
      initiate_checkout_cpa: initiateCheckoutCpa,
      initiate_checkout_cvr: initiateCheckoutCvr,
      submit_form: submitForm,
      submit_form_cpa: submitFormCpa,
      submit_form_cvr: submitFormCvr,
      contact: contact,
      contact_cpa: contactCpa,
      contact_cvr: contactCvr,
      sign_up: signUp,
      sign_up_cpa: signUpCpa,
      sign_up_cvr: signUpCvr,
      add_payment_info: addPaymentInfo,
      add_payment_info_cpa: addPaymentInfoCpa,
      add_payment_info_cvr: addPaymentInfoCvr,
      add_to_wish_list: addToWishList,
      add_to_wish_list_cpa: addToWishListCpa,
      add_to_wish_list_cvr: addToWishListCvr,
      visit_cart: visitCart,
      visit_cart_cpa: visitCartCpa,
      visit_cart_cvr: visitCartCvr,
      customize_product: customizeProduct,
      customize_product_cpa: customizeProductCpa,
      customize_product_cvr: customizeProductCvr,
      search: search,
      search_cpa: searchCpa,
      search_cvr: searchCvr,
      booking: booking,
      booking_cpa: bookingCpa,
      booking_cvr: bookingCvr,
      download: download,
      download_cpa: downloadCpa,
      download_cvr: downloadCvr,
      start_trial: startTrial,
      start_trial_cpa: startTrialCpa,
      start_trial_cvr: startTrialCvr,
      share: share,
      share_cpa: shareCpa,
      share_cvr: shareCvr,
      login: login,
      login_cpa: loginCpa,
      login_cvr: loginCvr,
      donate: donate,
      donate_cpa: donateCpa,
      donate_cvr: donateCvr,
      find_location: findLocation,
      find_location_cpa: findLocationCpa,
      find_location_cvr: findLocationCvr,
      time_spent: timeSpent,
      time_spent_cpa: timeSpentCpa,
      time_spent_cvr: timeSpentCvr,
      install: install,
      install_cpa: installCpa,
      install_cvr: installCvr,
    )
  end

  def self.protobuf_schema : ProtobufSchema::Schema
    ProtobufSchema.parse(protobuf_schema_string)
  end

  def self.protobuf_schema_string : String
    <<-EOF
      syntax = "proto2";
      
      message Amv2 {
        optional string  campaignId            = 1; // "1000004"
        optional string  campaignName          = 2; // "test"
        optional string  adGroupId             = 3; // "1000003"
        optional string  adGroupName           = 4; // "test"
        optional int64   campaignSpendingLimit = 5; // 100
        optional int64   campaignDailyBudget   = 6; // 100
        optional bool    isMigratedFromV1      = 7;
        optional int64   addToCart             = 8;
        optional int64   purchase              = 9;
        optional int64   subscribe             = 10;
        optional int64   completeRegistration  = 11;
        optional int64   viewContent           = 12;
        optional Float64 addToCartCpa          = 13;
        optional Float64 addToCartCvr          = 14;
        optional Float64 purchaseCpa           = 15;
        optional Float64 purchaseCvr           = 16;
        optional Float64 subscribeCpa          = 17;
        optional Float64 subscribeCvr          = 18;
        optional Float64 completeRegistrationCpa = 19;
        optional Float64 completeRegistrationCvr = 20;
        optional Float64 viewContentCpa        = 21;
        optional Float64 viewContentCvr        = 22;
        optional int64   initiateCheckout      = 23;
        optional Float64 initiateCheckoutCpa   = 24;
        optional Float64 initiateCheckoutCvr   = 25;
        optional int64   submitForm            = 26;
        optional Float64 submitFormCpa         = 27;
        optional Float64 submitFormCvr         = 28;
        optional int64   contact               = 29;
        optional Float64 contactCpa            = 30;
        optional Float64 contactCvr            = 31;
        optional int64   signUp                = 32;
        optional Float64 signUpCpa             = 33;
        optional Float64 signUpCvr             = 34;
        optional int64   addPaymentInfo        = 35;
        optional Float64 addPaymentInfoCpa     = 36;
        optional Float64 addPaymentInfoCvr     = 37;
        optional int64   addToWishList         = 38;
        optional Float64 addToWishListCpa      = 39;
        optional Float64 addToWishListCvr      = 40;
        optional int64   visitCart             = 41;
        optional Float64 visitCartCpa          = 42;
        optional Float64 visitCartCvr          = 43;
        optional int64   customizeProduct      = 44;
        optional Float64 customizeProductCpa   = 45;
        optional Float64 customizeProductCvr   = 46;
        optional int64   search                = 47;
        optional Float64 searchCpa             = 48;
        optional Float64 searchCvr             = 49;
        optional int64   booking               = 50;
        optional Float64 bookingCpa            = 51;
        optional Float64 bookingCvr            = 52;
        optional int64   download              = 53;
        optional Float64 downloadCpa           = 54;
        optional Float64 downloadCvr           = 55;
        optional int64   startTrial            = 56;
        optional Float64 startTrialCpa         = 57;
        optional Float64 startTrialCvr         = 58;
        optional int64   share                 = 59;
        optional Float64 shareCpa              = 60;
        optional Float64 shareCvr              = 61;
        optional int64   login                 = 62;
        optional Float64 loginCpa              = 63;
        optional Float64 loginCvr              = 64;
        optional int64   donate                = 65;
        optional Float64 donateCpa             = 66;
        optional Float64 donateCvr             = 67;
        optional int64   findLocation          = 68;
        optional Float64 findLocationCpa       = 69;
        optional Float64 findLocationCvr       = 70;
        optional int64   timeSpent             = 71;
        optional Float64 timeSpentCpa          = 72;
        optional Float64 timeSpentCvr          = 73;
        optional int64   install               = 74;
        optional Float64 installCpa            = 75;
        optional Float64 installCvr            = 76;
      }
      
      message Amv2Array {
        repeated Amv2 array = 1;
      }
      EOF
  end

  ######################################################################
  ### ClickHouse

  def self.clickhouse_create : Clickhouse::Schema::Create
    Clickhouse::Schema::Create.parse(clickhouse_schema_sql)
  end

  def self.clickhouse_schema_sql
    <<-EOF
      CREATE TABLE amv2 (
        campaign_id Nullable(String),
        campaign_name Nullable(String),
        ad_group_id Nullable(String),
        ad_group_name Nullable(String),
        campaign_spending_limit Nullable(Int64),
        campaign_daily_budget Nullable(Int64),
        is_migrated_from_v1 Nullable(Bool),
        add_to_cart Nullable(Int64),
        purchase Nullable(Int64),
        subscribe Nullable(Int64),
        complete_registration Nullable(Int64),
        view_content Nullable(Int64),
        add_to_cart_cpa Nullable(Float64),
        add_to_cart_cvr Nullable(Float64),
        purchase_cpa Nullable(Float64),
        purchase_cvr Nullable(Float64),
        subscribe_cpa Nullable(Float64),
        subscribe_cvr Nullable(Float64),
        complete_registration_cpa Nullable(Float64),
        complete_registration_cvr Nullable(Float64),
        view_content_cpa Nullable(Float64),
        view_content_cvr Nullable(Float64),
        initiate_checkout Nullable(Int64),
        initiate_checkout_cpa Nullable(Float64),
        initiate_checkout_cvr Nullable(Float64),
        submit_form Nullable(Int64),
        submit_form_cpa Nullable(Float64),
        submit_form_cvr Nullable(Float64),
        contact Nullable(Int64),
        contact_cpa Nullable(Float64),
        contact_cvr Nullable(Float64),
        sign_up Nullable(Int64),
        sign_up_cpa Nullable(Float64),
        sign_up_cvr Nullable(Float64),
        add_payment_info Nullable(Int64),
        add_payment_info_cpa Nullable(Float64),
        add_payment_info_cvr Nullable(Float64),
        add_to_wish_list Nullable(Int64),
        add_to_wish_list_cpa Nullable(Float64),
        add_to_wish_list_cvr Nullable(Float64),
        visit_cart Nullable(Int64),
        visit_cart_cpa Nullable(Float64),
        visit_cart_cvr Nullable(Float64),
        customize_product Nullable(Int64),
        customize_product_cpa Nullable(Float64),
        customize_product_cvr Nullable(Float64),
        search Nullable(Int64),
        search_cpa Nullable(Float64),
        search_cvr Nullable(Float64),
        booking Nullable(Int64),
        booking_cpa Nullable(Float64),
        booking_cvr Nullable(Float64),
        download Nullable(Int64),
        download_cpa Nullable(Float64),
        download_cvr Nullable(Float64),
        start_trial Nullable(Int64),
        start_trial_cpa Nullable(Float64),
        start_trial_cvr Nullable(Float64),
        share Nullable(Int64),
        share_cpa Nullable(Float64),
        share_cvr Nullable(Float64),
        login Nullable(Int64),
        login_cpa Nullable(Float64),
        login_cvr Nullable(Float64),
        donate Nullable(Int64),
        donate_cpa Nullable(Float64),
        donate_cvr Nullable(Float64),
        find_location Nullable(Int64),
        find_location_cpa Nullable(Float64),
        find_location_cvr Nullable(Float64),
        time_spent Nullable(Int64),
        time_spent_cpa Nullable(Float64),
        time_spent_cvr Nullable(Float64),
        install Nullable(Int64),
        install_cpa Nullable(Float64),
        install_cvr Nullable(Float64)
      )
      ENGINE = Log
      EOF
  end
end
