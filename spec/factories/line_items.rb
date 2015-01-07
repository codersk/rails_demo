FactoryGirl.define do
  factory :line_item do
    association :order
    association :product
    qty 2

    trait :line_item2 do
      qty 1
    end
  end
end
