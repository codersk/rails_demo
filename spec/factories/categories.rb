FactoryGirl.define do
  factory :category do
    name "san"    
    thumburl 'http://www.google.co.in'

    trait :category_with_empty_name do
      name ""
      thumburl 'http://www.google.co.in'
    end

    trait :category_with_false_data do
      name ""
      thumburl 'www.google.co.in'
    end

    trait :category_logicaly_invalid_data do
      name "123"
      thumburl 'http://www.google.co.in'
    end

    trait :category_with_invalid_name do
      name 1234
      thumburl 'http://www.google.co.in'
    end

    trait :category_with_no_thumurl do
      name "san"
      thumburl ''
    end
  end
end
