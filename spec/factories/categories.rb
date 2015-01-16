FactoryGirl.define do
  factory :category do
    name "san"    

    trait :category_with_empty_name do
      name ""
    end

    trait :category_logicaly_invalid_data do
      name "123"
    end

    trait :category_with_invalid_name do
      name 1234
    end
  end
end
