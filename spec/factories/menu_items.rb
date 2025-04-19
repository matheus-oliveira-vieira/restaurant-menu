FactoryBot.define do
  factory :menu_item do
    sequence(:name) { |n| "Item #{n}" }
    price { rand(5.0..50.0).round(2) }
    association :restaurant

    # Flexible association with menus (via join table)
    transient do
      menus { [] }
    end

    after(:create) do |item, evaluator|
      item.menus << evaluator.menus if evaluator.menus.any?
    end
  end
end
