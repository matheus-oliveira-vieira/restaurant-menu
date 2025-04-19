require 'rails_helper'

describe 'Menus API' do
  let!(:restaurant) { create(:restaurant) }
  let!(:menu) { create(:menu, restaurant: restaurant) }
  let!(:menu_item) { create(:menu_item, restaurant: restaurant, menus: [ menu ]) }

  describe 'GET /api/v1/restaurants/:restaurant_id/menus' do
    context 'when restaurant exists' do
      before { get api_v1_restaurant_menus_path(restaurant) }

      it 'returns HTTP success' do
        expect(response).to have_http_status(:ok)
      end

      it 'returns menus with items' do
        parsed = JSON.parse(response.body)

        expect(parsed).to be_an(Array)
        expect(parsed.first['id']).to eq(menu.id)
        expect(parsed.first['menu_items'].first['id']).to eq(menu_item.id)
      end
    end

    context 'when restaurant does not exist' do
      before { get api_v1_restaurant_menus_path(0) } # Invalid ID

      it 'returns not found status' do
        expect(response).to have_http_status(:not_found)
      end
    end
  end

  describe 'GET /api/v1/restaurants/:restaurant_id/menus/:id' do
    context 'when menu exists' do
      before { get api_v1_restaurant_menu_path(restaurant_id: restaurant.id, id: menu.id) }

      it 'returns HTTP success' do
        expect(response).to have_http_status(:ok)
      end

      it 'returns the complete menu structure' do
        parsed = JSON.parse(response.body)

        expect(parsed['id']).to eq(menu.id)
        expect(parsed['menu_items'].first['name']).to eq(menu_item.name)
      end
    end

    context 'when menu does not exist' do
      before { get api_v1_restaurant_menu_path(restaurant_id: restaurant.id, id: 0) }

      it 'returns not found status' do
        expect(response).to have_http_status(:not_found)
      end
    end
  end

  describe 'Error Handling' do
    context 'when restaurant does not exist' do
      before { get api_v1_restaurant_menus_path(0) }
      it 'returns 404 status' do
        expect(response).to have_http_status(:not_found)
      end

      it 'returns error message' do
        expect(JSON.parse(response.body)).to include('error' => 'Record not found')
      end
    end

    context 'when menu does not exist' do
      before { get api_v1_restaurant_menu_path(restaurant_id: restaurant.id, id: 0) }

      it 'returns 404 status' do
        expect(response).to have_http_status(:not_found)
      end
    end
  end
end
