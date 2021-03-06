FactoryGirl.define do
  factory(:user) do
    administrator false
    authentication_token "vAxymkkMvBEC-uamQ1by"
    avatar nil
    birth_year nil
    current_phase 1
    current_sign_in_at "2016-03-27T17:34 CDT"
    current_sign_in_ip "ToFactory: RubyParser exception parsing this attribute"
    sequence(:email){|n| "user#{n}@factory.com" }
    encrypted_password "ToFactory: RubyParser exception parsing this attribute"
    password 'password'
    experience_level 3
    first_name "Brian"
    hor_pull_max 150.0
    hor_push_max 250.0
    knee_dom_max 350.0
    last_name "Regan"
    last_plyometric_day_created 1
    last_sign_in_at "2016-03-27T17:30 CDT"
    last_sign_in_ip "ToFactory: RubyParser exception parsing this attribute"
    last_sprint_day_created 1
    last_warmup_day_created 1
    last_weight_day_created 0
    level 2
    master_user_id nil
    paid_tier 1
    phone nil
    points 0
    power_index nil
    program_type_id 3
    remember_created_at nil
    reset_password_sent_at nil
    reset_password_token nil
    sex "male"
    sign_in_count 71
    sprint_diff 1
    status 1
    sub_user false
    subscription_date nil
    user_name nil
    weight 150
  end
end
