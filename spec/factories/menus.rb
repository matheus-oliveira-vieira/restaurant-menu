FactoryBot.define do
  factory :menu do
    name { "Breakfast" }

    trait :with_items do
      after(:create) do |menu|
        create_list(:menu_item, 3, menu: menu)
      end
    end
  end
end
