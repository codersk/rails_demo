FactoryGirl.define do
  factory :line_item do
    product_id 4
    order_id 5
    qty 2

    trait :line_item_wrong_data do
      product_id 'a'
      order_id 5
      qty 1
    end
  end
end
