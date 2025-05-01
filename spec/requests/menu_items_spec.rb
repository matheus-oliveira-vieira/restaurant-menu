require 'rails_helper'

RSpec.describe Api::V1::MenuItemsController, type: :request do
  let!(:restaurant) { create(:restaurant) }
  let!(:menu) { create(:menu, restaurant: restaurant) }
  let!(:menu_item) { create(:menu_item, restaurant: restaurant, menus: [ menu ]) }
  let(:valid_attributes) { { menu_item: { name: "New Item", price: 9.99 } } }
  let(:invalid_attributes) { { menu_item: { name: "", price: nil } } }

  describe 'GET /api/v1/menu_items/:id' do
    context 'when menu item exists' do
      before { get api_v1_menu_item_path(menu_item) }

      it 'returns HTTP success' do
        parsed = JSON.parse(response.body)

        expect(response).to have_http_status(:ok)
        expect(parsed['id']).to eq(menu_item.id)
        expect(parsed['name']).to eq(menu_item.name)
      end
    end

    context 'when menu item does not exist' do
      before { get api_v1_menu_item_path(id: 0) }

      it 'returns not found status' do
        parsed = JSON.parse(response.body)

        expect(response).to have_http_status(:not_found)
        expect(parsed).to include('error' => 'Record not found')
      end
    end
  end

  describe 'POST /api/v1/restaurants/:restaurant_id/menus/:menu_id/menu_items' do
    context 'with valid parameters' do
      before { post api_v1_restaurant_menu_menu_items_path(restaurant, menu), params: valid_attributes }

      it 'creates a new menu item' do
        parsed = JSON.parse(response.body)

        expect(MenuItem.count).to eq(2)
        expect(response).to have_http_status(:created)
        expect(parsed['name']).to eq('New Item')
        expect(parsed['price']).to eq('9.99')
      end

      it 'associates the item with the menu' do
        item = MenuItem.last
        expect(item.menus).to include(menu)
      end
    end

    context 'with invalid parameters' do
      before { post api_v1_restaurant_menu_menu_items_path(restaurant, menu), params: invalid_attributes }

      it 'does not create a new menu item' do
        parsed = JSON.parse(response.body)

        expect(MenuItem.count).to eq(1)
        expect(response).to have_http_status(:unprocessable_entity)
        expect(parsed['errors']).to be_present
      end
    end

    context 'when restaurant does not exist' do
      before { post api_v1_restaurant_menu_menu_items_path(0, menu), params: valid_attributes }

      it 'returns not found status' do
        expect(response).to have_http_status(:not_found)
      end
    end

    context 'when menu does not exist' do
      before { post api_v1_restaurant_menu_menu_items_path(restaurant, 0), params: valid_attributes }

      it 'returns not found status' do
        expect(response).to have_http_status(:not_found)
      end
    end

    context 'when item already exists in menu' do
      let!(:existing_item) { create(:menu_item, restaurant: restaurant, menus: [ menu ]) }
      let(:existing_attributes) { { menu_item: { name: existing_item.name, price: existing_item.price } } }

      it 'associates existing item with menu' do
        expect {
          post api_v1_restaurant_menu_menu_items_path(restaurant, menu), params: existing_attributes
        }.not_to change(MenuItem, :count)

        expect(existing_item.reload.menus).to include(menu)
      end
    end
  end
end
