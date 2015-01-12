FactoryGirl.define do
  factory :product do
    name "san"
    price 5.0
    tax_rate 1.2
    description "sdlahsdflasndfl"
    association :category

    trait :product_1 do
      name ""
      price 12.0
      tax_rate 230
    end

    trait :product_2 do
      name "pen"
      price nil
      tax_rate 2.3
    end

    trait :product_3 do
      name "pen"
      price -15
      tax_rate 2.3
    end

    trait :product_4 do
      name "pen"
      price 'abc'
      tax_rate 2.3
    end

    trait :product_5 do
      name "pen"
      price 15
      tax_rate nil
    end
  end
end
