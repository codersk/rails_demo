FactoryGirl.define do
  factory :order do
    billing_address "BTM"
    shipping_address "BEML"
    status "cart"
    association :user

    trait :order_1 do
      billing_address "BTM"
      shipping_address "BEML"
      total 0.0
    end

    trait :order_2 do
      billing_address ""
      shipping_address "BEML"
      status "cart"
    end

    trait :order_3 do
      billing_address "BTM"
      shipping_address ""
      status "pending"
    end

    trait :order_4 do
      billing_address "BTM"
      shipping_address "BEML"
      status "checkout"
    end

    trait :order_5 do
      billing_address ""
      shipping_address ""
      status "cart"
    end
  end
end
