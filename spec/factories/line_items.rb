FactoryGirl.define do
  factory :line_item do
    order_id 5
    product_id 4
    qty 2
    tax 1.2
    unit_price 5.0
    total 10.12

    trait :line_item2 do
      order_id 5
      product_id 2
      qty 1
      tax 1.2
      unit_price 5.0
      total 5.06
    end

    trait :line_item_wrong_data do
      product_id 'a'
      order_id 5
      qty 1
      tax 1.2
      unit_price 5.0
      total 5.06
    end
  end
end
