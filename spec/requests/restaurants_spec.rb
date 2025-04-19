require 'rails_helper'

describe 'Api::V1::Restaurants' do
  let!(:restaurant) { create(:restaurant, :with_menus) }

  describe 'GET /api/v1/restaurants' do
    before { get api_v1_restaurants_path }

    it 'returns correct structure with menus and items' do
      parsed = JSON.parse(response.body)
      first_restaurant = parsed.first

      expect(first_restaurant['menus']).to be_an(Array)
      expect(first_restaurant['menus'].size).to eq(2)

      first_menu = first_restaurant['menus'].first
      expect(first_menu['menu_items']).to be_an(Array)
      expect(first_menu['menu_items'].size).to eq(3)
    end
  end

  describe 'GET /api/v1/restaurants/:id' do
    before { get api_v1_restaurant_path(restaurant) }

    it 'returns the restaurant with menus and items' do
      parsed = JSON.parse(response.body)
      expect(parsed['menus'].size).to eq(2)

      first_menu = parsed['menus'].first
      expect(first_menu['menu_items'].size).to eq(3)
      expect(first_menu['menu_items'].first).to include('id', 'name', 'price')
    end
  end

  describe 'Error Handling' do
    context 'when restaurant does not exist' do
      before { get api_v1_restaurant_path(id: 0) }

      it 'returns 404 status' do
        expect(response).to have_http_status(:not_found)
      end
    end
  end
end
