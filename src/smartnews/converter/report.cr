class Smartnews::Converter::Report
  ######################################################################
  ### JSON

  JSON.mapping({
    date:                       String   , # "2019-12-31"
    accountId:                  String?  , # "1000000"
    campaignId:                 String?  , # "1000003"
    creativeId:                 String?  , # "1000013"
    accountName:                String?  , # "SmartNews, Inc"
    campaignName:               String?  , # "SmartNews Installs 7/12"
    creativeName:               String?  , # "label for creative management"
    impressions:                Int64?   , # 13204
    viewableImpressions:        Int64?   , # 10444
    clicks:                     Int64?   , # 48
    conversions:                Int64?   , # 3
    spend:                      Float64? , # 1052.5128
    cpm:                        Float64? , # 100.77678752999999
    cpc:                        Float64? , # 21.92734935
    ctr:                        Float64? , # 0.36353
    vctr:                       Float64? , # 0.45959
    cvr:                        Float64? , # 6.25
    cpa:                        Float64? , # 350.83758967
    actionType:                 String?  , # "WEBSITE_CONVERSION"
    enable:                     Bool?    , # true
    startTime:                  String?  , # "2019-09-17T15:00:00Z"
    endTime:                    String?  , # "2020-02-29T14:59:00Z"
    totalBudget:                Int64?   , # 1026473
    dailyBudget:                Int64?   , # 4116
    bidAmount:                  Int64?   , # 50
    billingEvent:               String?  , # "CLICKS"
    isAutoBid:                  Bool?    , # true
    sponsoredName:              String?  , # "SmartAds"
    targetCpa:                  Int64?   , # 0
    status:                     String?  , # "NORMAL"
    approvalStatus:             String?  , # "APPROVED"
    updatedAt:                  String?  , # "2020-01-31T02:02:03Z"
    adcreativeId:               String?  , # "10000005"
    creativeType:               String?  , # "IMAGE"
    isDynamicCreative:          Bool?    , # false
    immutable:                  Bool?    , # true
    title:                      String?  , # "Trending News & Stories"
    text:                       String?  , # "Your news in one minute."
    linkUrl:                    String?  , # "http://creative.smartnews-ads.com"
    trackingUrl:                String?  , # "http://foo.trackingsystem.com/?a=b&c=d&e=f"
    videoAvgViewRate:           Float64? , # 41.20017
    videoAvgViewTime:           Float64? , # 4085.73368
    videoCompleteViewRate:      Float64? , # 43.09866
    videoCompleteViews:         Int64?   , # 1861
    videoLength:                Int64?   , # 9915
    videoP100Views:             Int64?   , # 1861
    videoP25Views:              Int64?   , # 3426
    videoP50Views:              Int64?   , # 2834
    videoP75Views:              Int64?   , # 2266
    videoP95Views:              Int64?   , # 1876
    videoViewableViews:         Int64?   , # 3603
    videoViews:                 Int64?   , # 4318
    imageId:                    String?  , #
    imageUrl:                   String?  , #
    width:                      Int64?   , #
    height:                     Int64?   , #
    viewContent:                Int64?   , #
    purchase:                   Int64?   , #
    addToCart:                  Int64?   , #
    completeRegistration:       Int64?   , #
    subscribe:                  Int64?   , #
    amv2_campaignId:            String?  , # "1000004"
    amv2_campaignName:          String?  , # "test"
    amv2_adGroupId:             String?  , # "1000003"
    amv2_adGroupName:           String?  , # "test"
    amv2_campaignSpendingLimit: Int64?   , # 100
    amv2_campaignDailyBudget:   Int64?   , # 100
    amv2_isMigratedFromV1:      Bool?    ,
    amv2_addToCart:             Int64?   ,
    amv2_purchase:              Int64?   ,
    amv2_subscribe:             Int64?   ,
    amv2_completeRegistration:  Int64?   ,
    amv2_viewContent:           Int64?   ,
    amv2_addToCartCpa:          Float64? ,
    amv2_addToCartCvr:          Float64? ,
    amv2_purchaseCpa:           Float64? ,
    amv2_purchaseCvr:           Float64? ,
    amv2_subscribeCpa:          Float64? ,
    amv2_subscribeCvr:          Float64? ,
    amv2_completeRegistrationCpa: Float64? ,
    amv2_completeRegistrationCvr: Float64? ,
    amv2_viewContentCpa:        Float64? ,
    amv2_viewContentCvr:        Float64? ,
    amv2_initiate_checkout:     Int64?   ,
    amv2_initiate_checkout_cpa: Float64? ,
    amv2_initiate_checkout_cvr: Float64? ,
    amv2_submit_form:           Int64?   ,
    amv2_submit_form_cpa:       Float64? ,
    amv2_submit_form_cvr:       Float64? ,
    amv2_contact:               Int64?   ,
    amv2_contact_cpa:           Float64? ,
    amv2_contact_cvr:           Float64? ,
    amv2_sign_up:               Int64?   ,
    amv2_sign_up_cpa:           Float64? ,
    amv2_sign_up_cvr:           Float64? ,
    amv2_add_payment_info:      Int64?   ,
    amv2_add_payment_info_cpa:  Float64? ,
    amv2_add_payment_info_cvr:  Float64? ,
    amv2_add_to_wish_list:      Int64?   ,
    amv2_add_to_wish_list_cpa:  Float64? ,
    amv2_add_to_wish_list_cvr:  Float64? ,
    amv2_visit_cart:            Int64?   ,
    amv2_visit_cart_cpa:        Float64? ,
    amv2_visit_cart_cvr:        Float64? ,
    amv2_customize_product:     Int64?   ,
    amv2_customize_product_cpa: Float64? ,
    amv2_customize_product_cvr: Float64? ,
    amv2_search:                Int64?   ,
    amv2_search_cpa:            Float64? ,
    amv2_search_cvr:            Float64? ,
    amv2_booking:               Int64?   ,
    amv2_booking_cpa:           Float64? ,
    amv2_booking_cvr:           Float64? ,
    amv2_download:              Int64?   ,
    amv2_download_cpa:          Float64? ,
    amv2_download_cvr:          Float64? ,
    amv2_start_trial:           Int64?   ,
    amv2_start_trial_cpa:       Float64? ,
    amv2_start_trial_cvr:       Float64? ,
    amv2_share:                 Int64?   ,
    amv2_share_cpa:             Float64? ,
    amv2_share_cvr:             Float64? ,
    amv2_login:                 Int64?   ,
    amv2_login_cpa:             Float64? ,
    amv2_login_cvr:             Float64? ,
    amv2_donate:                Int64?   ,
    amv2_donate_cpa:            Float64? ,
    amv2_donate_cvr:            Float64? ,
    amv2_find_location:         Int64?   ,
    amv2_find_location_cpa:     Float64? ,
    amv2_find_location_cvr:     Float64? ,
    amv2_time_spent:            Int64?   ,
    amv2_time_spent_cpa:        Float64? ,
    amv2_time_spent_cvr:        Float64? ,
    amv2_install:               Int64?   ,
    amv2_install_cpa:           Float64? ,
    amv2_install_cvr:           Float64? ,
  })

  ######################################################################
  ### Protobuf

  def to_pb
    Smartnews::Proto::Report.new(
      date: date,
      account_id: accountId,
      campaign_id: campaignId,
      creative_id: creativeId,
      account_name: accountName,
      campaign_name: campaignName,
      creative_name: creativeName,
      impressions: impressions,
      viewable_impressions: viewableImpressions,
      clicks: clicks,
      conversions: conversions,
      spend: spend,
      cpm: cpm,
      cpc: cpc,
      ctr: ctr,
      vctr: vctr,
      cvr: cvr,
      cpa: cpa,
      action_type: actionType,
      enable: enable,
      start_time: startTime,
      end_time: endTime,
      total_budget: totalBudget,
      daily_budget: dailyBudget,
      bid_amount: bidAmount,
      billing_event: billingEvent,
      is_auto_bid: isAutoBid,
      sponsored_name: sponsoredName,
      target_cpa: targetCpa,
      status: status,
      approval_status: approvalStatus,
      updated_at: updatedAt,
      adcreative_id: adcreativeId,
      creative_type: creativeType,
      is_dynamic_creative: isDynamicCreative,
      immutable: immutable,
      title: title,
      text: text,
      link_url: linkUrl,
      tracking_url: trackingUrl,
      video_avg_view_rate: videoAvgViewRate,
      video_avg_view_time: videoAvgViewTime,
      video_complete_view_rate: videoCompleteViewRate,
      video_complete_views: videoCompleteViews,
      video_length: videoLength,
      video_p100_views: videoP100Views,
      video_p25_views: videoP25Views,
      video_p50_views: videoP50Views,
      video_p75_views: videoP75Views,
      video_p95_views: videoP95Views,
      video_viewable_views: videoViewableViews,
      video_views: videoViews,
      image_id: imageId,
      image_url: imageUrl,
      width: width,
      height: height,
      view_content: viewContent,
      purchase: purchase,
      add_to_cart: addToCart,
      complete_registration: completeRegistration,
      subscribe: subscribe,
      amv2_campaign_id: amv2_campaignId,
      amv2_campaign_name: amv2_campaignName,
      amv2_ad_group_id: amv2_adGroupId,
      amv2_ad_group_name: amv2_adGroupName,
      amv2_campaign_spending_limit: amv2_campaignSpendingLimit,
      amv2_campaign_daily_budget: amv2_campaignDailyBudget,
      amv2_is_migrated_from_v1: amv2_isMigratedFromV1,
      amv2_add_to_cart: amv2_addToCart,
      amv2_purchase: amv2_purchase,
      amv2_subscribe: amv2_subscribe,
      amv2_complete_registration: amv2_completeRegistration,
      amv2_view_content: amv2_viewContent,
      amv2_add_to_cart_cpa: amv2_addToCartCpa,
      amv2_add_to_cart_cvr: amv2_addToCartCvr,
      amv2_purchase_cpa: amv2_purchaseCpa,
      amv2_purchase_cvr: amv2_purchaseCvr,
      amv2_subscribe_cpa: amv2_subscribeCpa,
      amv2_subscribe_cvr: amv2_subscribeCvr,
      amv2_complete_registration_cpa: amv2_completeRegistrationCpa,
      amv2_complete_registration_cvr: amv2_completeRegistrationCvr,
      amv2_view_content_cpa: amv2_viewContentCpa,
      amv2_view_content_cvr: amv2_viewContentCvr,
      amv2_initiate_checkout: amv2_initiateCheckout,
      amv2_initiate_checkout_cpa: amv2_initiateCheckoutCpa,
      amv2_initiate_checkout_cvr: amv2_initiateCheckoutCvr,
      amv2_submit_form: amv2_submitForm,
      amv2_submit_form_cpa: amv2_submitFormCpa,
      amv2_submit_form_cvr: amv2_submitFormCvr,
      amv2_contact: amv2_contact,
      amv2_contact_cpa: amv2_contactCpa,
      amv2_contact_cvr: amv2_contactCvr,
      amv2_sign_up: amv2_signUp,
      amv2_sign_up_cpa: amv2_signUpCpa,
      amv2_sign_up_cvr: amv2_signUpCvr,
      amv2_add_payment_info: amv2_addPaymentInfo,
      amv2_add_payment_info_cpa: amv2_addPaymentInfoCpa,
      amv2_add_payment_info_cvr: amv2_addPaymentInfoCvr,
      amv2_add_to_wish_list: amv2_addToWishList,
      amv2_add_to_wish_list_cpa: amv2_addToWishListCpa,
      amv2_add_to_wish_list_cvr: amv2_addToWishListCvr,
      amv2_visit_cart: amv2_visitCart,
      amv2_visit_cart_cpa: amv2_visitCartCpa,
      amv2_visit_cart_cvr: amv2_visitCartCvr,
      amv2_customize_product: amv2_customizeProduct,
      amv2_customize_product_cpa: amv2_customizeProductCpa,
      amv2_customize_product_cvr: amv2_customizeProductCvr,
      amv2_search: amv2_search,
      amv2_search_cpa: amv2_searchCpa,
      amv2_search_cvr: amv2_searchCvr,
      amv2_booking: amv2_booking,
      amv2_booking_cpa: amv2_bookingCpa,
      amv2_booking_cvr: amv2_bookingCvr,
      amv2_download: amv2_download,
      amv2_download_cpa: amv2_downloadCpa,
      amv2_download_cvr: amv2_downloadCvr,
      amv2_start_trial: amv2_startTrial,
      amv2_start_trial_cpa: amv2_startTrialCpa,
      amv2_start_trial_cvr: amv2_startTrialCvr,
      amv2_share: amv2_share,
      amv2_share_cpa: amv2_shareCpa,
      amv2_share_cvr: amv2_shareCvr,
      amv2_login: amv2_login,
      amv2_login_cpa: amv2_loginCpa,
      amv2_login_cvr: amv2_loginCvr,
      amv2_donate: amv2_donate,
      amv2_donate_cpa: amv2_donateCpa,
      amv2_donate_cvr: amv2_donateCvr,
      amv2_find_location: amv2_findLocation,
      amv2_find_location_cpa: amv2_findLocationCpa,
      amv2_find_location_cvr: amv2_findLocationCvr,
      amv2_time_spent: amv2_timeSpent,
      amv2_time_spent_cpa: amv2_timeSpentCpa,
      amv2_time_spent_cvr: amv2_timeSpentCvr,
      amv2_install: amv2_install,
      amv2_install_cpa: amv2_installCpa,
      amv2_install_cvr: amv2_installCvr,
    )
  end

  def self.protobuf_schema : ProtobufSchema::Schema
    ProtobufSchema.parse(protobuf_schema_string)
  end

  def self.protobuf_schema_string : String
    <<-EOF
      syntax = "proto2";
      
      message Report {
        required string date                =  1; // "2019-12-31"
      
        // insight
        optional string accountId           =  2; // "1000000"
        optional string campaignId          =  3; // "1000003"
        optional string creativeId          =  4; // "1000013"
        optional string accountName         =  5; // "SmartNews, Inc"
        optional string campaignName        =  6; // "SmartNews Installs 7/12"
        optional string creativeName        =  7; // "label for creative management"
        optional int64  impressions         =  8; // 13204
        optional int64  viewableImpressions =  9; // 10444
        optional int64  clicks              = 10; // 48
        optional int64  conversions         = 11; // 3
        optional double spend               = 12; // 1052.5128
        optional double cpm                 = 13; // 100.77678752999999
        optional double cpc                 = 14; // 21.92734935
        optional double ctr                 = 15; // 0.36353
        optional double vctr                = 16; // 0.45959
        optional double cvr                 = 17; // 6.25
        optional double cpa                 = 18; // 350.83758967
      
        // campaign
        optional string actionType     = 19; // "WEBSITE_CONVERSION"
        optional bool   enable         = 20; // true
        optional string startTime      = 21; // "2019-09-17T15:00:00Z"
        optional string endTime        = 22; // "2020-02-29T14:59:00Z"
        optional int64  totalBudget    = 23; // 1026473
        optional int64  dailyBudget    = 24; // 4116
        optional int64  bidAmount      = 25; // 50
        optional string billingEvent   = 26; // "CLICKS"
        optional bool   isAutoBid      = 27; // true
        optional string sponsoredName  = 28; // "SmartAds"
        optional int64  targetCpa      = 29; // 0
        optional string status         = 30; // "NORMAL"
        optional string approvalStatus = 31; // "APPROVED"
        optional string updatedAt      = 32; // "2020-01-31T02:02:03Z"
      
        // creative
        optional string adcreativeId      = 33; // "10000005"
        optional string creativeType      = 34; // "IMAGE"
        optional bool   isDynamicCreative = 35; // false
        optional bool   immutable         = 36; // true
        optional string title             = 37; // "Trending News & Stories"
        optional string text              = 38; // "Your news in one minute."
        optional string linkUrl           = 39; // "http://creative.smartnews-ads.com"
        optional string trackingUrl       = 40; //  "http://foo.trackingsystem.com/?a=b&c=d&e=f"
      
        // video metrics (insight)
        optional double videoAvgViewRate      = 41; // 41.20017
        optional double videoAvgViewTime      = 42; // 4085.73368
        optional double videoCompleteViewRate = 43; // 43.09866
        optional int64  videoCompleteViews    = 44; // 1861
        optional int64  videoLength           = 45; // 9915
        optional int64  videoP100Views        = 46; // 1861
        optional int64  videoP25Views         = 47; // 3426
        optional int64  videoP50Views         = 48; // 2834
        optional int64  videoP75Views         = 49; // 2266
        optional int64  videoP95Views         = 50; // 1876
        optional int64  videoViewableViews    = 51; // 3603
        optional int64  videoViews            = 52; // 4318
      
        // imageinfo (creative)
        optional string imageId               = 53;
        optional string imageUrl              = 54;
        optional int64  width                 = 55;
        optional int64  height                = 56;
        
        // insight
        optional int64  viewContent           = 57;
        optional int64  purchase              = 58;
        optional int64  addToCart             = 59;
        optional int64  completeRegistration  = 60;
        optional int64  subscribe             = 61;
      
        // campaign.amV2
        optional string amv2_campaignId            = 62; // "1000004"
        optional string amv2_campaignName          = 63; // "test"
        optional string amv2_adGroupId             = 64; // "1000003"
        optional string amv2_adGroupName           = 65; // "test"
        optional int64  amv2_campaignSpendingLimit = 66; // 100
        optional int64  amv2_campaignDailyBudget   = 67; // 100
        
        // insight.amV2
        optional bool   amv2_isMigratedFromV1      = 68;
        optional int64  amv2_addToCart             = 69;
        optional int64  amv2_purchase              = 70;
        optional int64  amv2_subscribe             = 71;
        optional int64  amv2_completeRegistration  = 72;
        optional int64  amv2_viewContent           = 73;
        optional double amv2_addToCartCpa          = 74;
        optional double amv2_addToCartCvr          = 75;
        optional double amv2_purchaseCpa           = 76;
        optional double amv2_purchaseCvr           = 77;
        optional double amv2_subscribeCpa          = 78;
        optional double amv2_subscribeCvr          = 79;
        optional double amv2_completeRegistrationCpa = 80;
        optional double amv2_completeRegistrationCvr = 81;
        optional double amv2_viewContentCpa        = 82;
        optional double amv2_viewContentCvr        = 83;
        optional int64  amv2_initiateCheckout      = 84;
        optional double amv2_initiateCheckoutCpa   = 85;
        optional double amv2_initiateCheckoutCvr   = 86;
        optional int64  amv2_submitForm            = 87;
        optional double amv2_submitFormCpa         = 88;
        optional double amv2_submitFormCvr         = 89;
        optional int64  amv2_contact               = 90;
        optional double amv2_contactCpa            = 91;
        optional double amv2_contactCvr            = 92;
        optional int64  amv2_signUp                = 93;
        optional double amv2_signUpCpa             = 94;
        optional double amv2_signUpCvr             = 95;
        optional int64  amv2_addPaymentInfo        = 96;
        optional double amv2_addPaymentInfoCpa     = 97;
        optional double amv2_addPaymentInfoCvr     = 98;
        optional int64  amv2_addToWishList         = 99;
        optional double amv2_addToWishListCpa      = 100;
        optional double amv2_addToWishListCvr      = 101;
        optional int64  amv2_visitCart             = 102;
        optional double amv2_visitCartCpa          = 103;
        optional double amv2_visitCartCvr          = 104;
        optional int64  amv2_customizeProduct      = 105;
        optional double amv2_customizeProductCpa   = 106;
        optional double amv2_customizeProductCvr   = 107;
        optional int64  amv2_search                = 108;
        optional double amv2_searchCpa             = 109;
        optional double amv2_searchCvr             = 110;
        optional int64  amv2_booking               = 111;
        optional double amv2_bookingCpa            = 112;
        optional double amv2_bookingCvr            = 113;
        optional int64  amv2_download              = 114;
        optional double amv2_downloadCpa           = 115;
        optional double amv2_downloadCvr           = 116;
        optional int64  amv2_startTrial            = 117;
        optional double amv2_startTrialCpa         = 118;
        optional double amv2_startTrialCvr         = 119;
        optional int64  amv2_share                 = 120;
        optional double amv2_shareCpa              = 121;
        optional double amv2_shareCvr              = 122;
        optional int64  amv2_login                 = 123;
        optional double amv2_loginCpa              = 124;
        optional double amv2_loginCvr              = 125;
        optional int64  amv2_donate                = 126;
        optional double amv2_donateCpa             = 127;
        optional double amv2_donateCvr             = 128;
        optional int64  amv2_findLocation          = 129;
        optional double amv2_findLocationCpa       = 130;
        optional double amv2_findLocationCvr       = 131;
        optional int64  amv2_timeSpent             = 132;
        optional double amv2_timeSpentCpa          = 133;
        optional double amv2_timeSpentCvr          = 134;
        optional int64  amv2_install               = 135;
        optional double amv2_installCpa            = 136;
        optional double amv2_installCvr            = 137;
      }
      
      message ReportArray {
        repeated Report array =  1; 
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
      CREATE TABLE report (
        date String,
        account_id Nullable(String),
        campaign_id Nullable(String),
        creative_id Nullable(String),
        account_name Nullable(String),
        campaign_name Nullable(String),
        creative_name Nullable(String),
        impressions Nullable(Int64),
        viewable_impressions Nullable(Int64),
        clicks Nullable(Int64),
        conversions Nullable(Int64),
        spend Nullable(Float64),
        cpm Nullable(Float64),
        cpc Nullable(Float64),
        ctr Nullable(Float64),
        vctr Nullable(Float64),
        cvr Nullable(Float64),
        cpa Nullable(Float64),
        action_type Nullable(String),
        enable Nullable(UInt8),
        start_time Nullable(String),
        end_time Nullable(String),
        total_budget Nullable(Int64),
        daily_budget Nullable(Int64),
        bid_amount Nullable(Int64),
        billing_event Nullable(String),
        is_auto_bid Nullable(UInt8),
        sponsored_name Nullable(String),
        target_cpa Nullable(Int64),
        status Nullable(String),
        approval_status Nullable(String),
        updated_at Nullable(String),
        adcreative_id Nullable(String),
        creative_type Nullable(String),
        is_dynamic_creative Nullable(UInt8),
        immutable Nullable(UInt8),
        title Nullable(String),
        text Nullable(String),
        link_url Nullable(String),
        tracking_url Nullable(String),
        video_avg_view_rate Nullable(Float64),
        video_avg_view_time Nullable(Float64),
        video_complete_view_rate Nullable(Float64),
        video_complete_views Nullable(Int64),
        video_length Nullable(Int64),
        video_p100_views Nullable(Int64),
        video_p25_views Nullable(Int64),
        video_p50_views Nullable(Int64),
        video_p75_views Nullable(Int64),
        video_p95_views Nullable(Int64),
        video_viewable_views Nullable(Int64),
        video_views Nullable(Int64),
        image_id Nullable(String),
        image_url Nullable(String),
        width Nullable(Int64),
        height Nullable(Int64),
        view_content Nullable(Int64),
        purchase Nullable(Int64),
        add_to_cart Nullable(Int64),
        complete_registration Nullable(Int64),
        subscribe Nullable(Int64),
        amv2_campaign_id Nullable(String),
        amv2_campaign_name Nullable(String),
        amv2_ad_group_id Nullable(String),
        amv2_ad_group_name Nullable(String),
        amv2_campaign_spending_limit Nullable(Int64),
        amv2_campaign_daily_budget Nullable(Int64),
        amv2_is_migrated_from_v1 Nullable(UInt8),
        amv2_add_to_cart Nullable(Int64),
        amv2_purchase Nullable(Int64),
        amv2_subscribe Nullable(Int64),
        amv2_complete_registration Nullable(Int64),
        amv2_view_content Nullable(Int64),
        amv2_add_to_cart_cpa Nullable(Float64),
        amv2_add_to_cart_cvr Nullable(Float64),
        amv2_purchase_cpa Nullable(Float64),
        amv2_purchase_cvr Nullable(Float64),
        amv2_subscribe_cpa Nullable(Float64),
        amv2_subscribe_cvr Nullable(Float64),
        amv2_complete_registration_cpa Nullable(Float64),
        amv2_complete_registration_cvr Nullable(Float64),
        amv2_view_content_cpa Nullable(Float64),
        amv2_view_content_cvr Nullable(Float64),
        amv2_initiate_checkout Nullable(Int64),
        amv2_initiate_checkout_cpa Nullable(Float64),
        amv2_initiate_checkout_cvr Nullable(Float64),
        amv2_submit_form Nullable(Int64),
        amv2_submit_form_cpa Nullable(Float64),
        amv2_submit_form_cvr Nullable(Float64),
        amv2_contact Nullable(Int64),
        amv2_contact_cpa Nullable(Float64),
        amv2_contact_cvr Nullable(Float64),
        amv2_sign_up Nullable(Int64),
        amv2_sign_up_cpa Nullable(Float64),
        amv2_sign_up_cvr Nullable(Float64),
        amv2_add_payment_info Nullable(Int64),
        amv2_add_payment_info_cpa Nullable(Float64),
        amv2_add_payment_info_cvr Nullable(Float64),
        amv2_add_to_wish_list Nullable(Int64),
        amv2_add_to_wish_list_cpa Nullable(Float64),
        amv2_add_to_wish_list_cvr Nullable(Float64),
        amv2_visit_cart Nullable(Int64),
        amv2_visit_cart_cpa Nullable(Float64),
        amv2_visit_cart_cvr Nullable(Float64),
        amv2_customize_product Nullable(Int64),
        amv2_customize_product_cpa Nullable(Float64),
        amv2_customize_product_cvr Nullable(Float64),
        amv2_search Nullable(Int64),
        amv2_search_cpa Nullable(Float64),
        amv2_search_cvr Nullable(Float64),
        amv2_booking Nullable(Int64),
        amv2_booking_cpa Nullable(Float64),
        amv2_booking_cvr Nullable(Float64),
        amv2_download Nullable(Int64),
        amv2_download_cpa Nullable(Float64),
        amv2_download_cvr Nullable(Float64),
        amv2_start_trial Nullable(Int64),
        amv2_start_trial_cpa Nullable(Float64),
        amv2_start_trial_cvr Nullable(Float64),
        amv2_share Nullable(Int64),
        amv2_share_cpa Nullable(Float64),
        amv2_share_cvr Nullable(Float64),
        amv2_login Nullable(Int64),
        amv2_login_cpa Nullable(Float64),
        amv2_login_cvr Nullable(Float64),
        amv2_donate Nullable(Int64),
        amv2_donate_cpa Nullable(Float64),
        amv2_donate_cvr Nullable(Float64),
        amv2_find_location Nullable(Int64),
        amv2_find_location_cpa Nullable(Float64),
        amv2_find_location_cvr Nullable(Float64),
        amv2_time_spent Nullable(Int64),
        amv2_time_spent_cpa Nullable(Float64),
        amv2_time_spent_cvr Nullable(Float64),
        amv2_install Nullable(Int64),
        amv2_install_cpa Nullable(Float64),
        amv2_install_cvr Nullable(Float64)
      )
      ENGINE = Log
      EOF
  end
end
