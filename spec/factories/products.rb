FactoryGirl.define do
  factory :product do
    product_name "san"
    price 12.0
    tax_rate 2.3
    description "sdlahsdflasndfl"
    thumburl 'http://www.google.co.in'
    association :category

    trait :product_1 do
      product_name ""
      price 12.0
      tax_rate 230
      thumburl 'http://www.google.co.in'
    end

    trait :product_2 do
      product_name ""
      price -15
      tax_rate 2.3
      thumburl 'www.google.co.in'
    end

    trait :product_3 do
      product_name "123"
      price 15
      tax_rate 2.3
      thumburl 'http://'
    end

    trait :product_4 do
      product_name 1234
      price -15
      tax_rate 2.3
      thumburl 'http://www.google.co.in'
    end

    trait :product_5 do
      product_name ""
      price -15
      tax_rate 2.3
      thumburl 'www.google.co.in'
    end
  end
end
