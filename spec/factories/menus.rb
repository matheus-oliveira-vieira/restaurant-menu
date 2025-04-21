FactoryBot.define do
  factory :menu do
    name { "Breakfast" }
    association :restaurant

    trait :with_items do
      after(:create) do |menu|
        items = create_list(:menu_item, 3, restaurant: menu.restaurant)
        menu.menu_items << items
      end
    end
  end
end
