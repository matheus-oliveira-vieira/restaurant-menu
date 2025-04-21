require 'rails_helper'

describe 'JsonImporter' do
  let(:json_data) do
    {
      "restaurants" => [
        {
          "name" => "Poppo's Cafe",
          "menus" => [
            {
              "name" => "lunch",
              "menu_items" => [
                { "name" => "Burger", "price" => 9.00 },
                { "name" => "Small Salad", "price" => 5.00 }
              ]
            },
            {
              "name" => "dinner",
              "menu_items" => [
                { "name" => "Burger", "price" => 15.00 },
                { "name" => "Large Salad", "price" => 8.00 }
              ]
            }
          ]
        }
      ]
    }
  end

  it "imports restaurant, menus and menu items without duplication" do
    logs = JsonImporter.call(json_data)

    restaurant = Restaurant.find_by(name: "Poppo's Cafe")
    expect(restaurant).to be_present
    expect(restaurant.menus.count).to eq(2)

    lunch_menu = restaurant.menus.find_by(name: "lunch")
    dinner_menu = restaurant.menus.find_by(name: "dinner")

    expect(lunch_menu.menu_items.pluck(:name)).to match_array([ "Burger", "Small Salad" ])
    expect(dinner_menu.menu_items.pluck(:name)).to match_array([ "Burger", "Large Salad" ])

    # Check that Burger was only created once in the bank
    expect(MenuItem.where(name: "Burger").count).to eq(1)

    # Logs should include expected messages
    expect(logs.any? { |log| log.include?("Importing restaurant: Poppo's Cafe") }).to be true
    expect(logs.any? { |log| log.include?("Menu: lunch") }).to be true
    expect(logs.any? { |log| log.include?("Added item: Burger") }).to be true
  end
end
