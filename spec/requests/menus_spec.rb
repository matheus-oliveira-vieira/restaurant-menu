require 'rails_helper'

describe 'Menus API' do
  let!(:restaurant) { create(:restaurant) }
  let!(:menu) { create(:menu, restaurant: restaurant) }
  let!(:menu_item) { create(:menu_item, restaurant: restaurant, menus: [ menu ]) }
  let(:valid_attributes) { { menu: { name: "New Menu" } } }
  let(:invalid_attributes) { { menu: { name: "" } } }

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
        expect(JSON.parse(response.body)).to include('error' => 'Record not found')
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

  describe 'POST /api/v1/restaurants/:restaurant_id/menus' do
    before { post api_v1_restaurant_menus_path(restaurant), params: valid_attributes }

    it 'creates a new menu' do
      parsed = JSON.parse(response.body)

      expect(Restaurant.count).to eq(1)
      expect(response).to have_http_status(:created)
      expect(parsed['name']).to eq('New Menu')
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

    context 'when tries to create a menu with invalid parameters' do
      before { post api_v1_restaurant_menus_path(restaurant), params: invalid_attributes }
      it 'does not create a new menu' do
        parsed = JSON.parse(response.body)

        expect(Restaurant.count).to eq(1) # 1 from let!(:menu) + 0 from invalid POST
        expect(response).to have_http_status(:unprocessable_entity)
        expect(parsed['errors']).to be_present
      end
    end

    context 'when tries to create a menu with a invalid restaurant' do
      before { post api_v1_restaurant_menus_path(0), params: valid_attributes }

      it 'returns not found status' do
        expect(response).to have_http_status(:not_found)
      end
    end
  end
end
