require 'rails_helper'

describe 'Api::V1::Restaurants' do
  let!(:restaurant) { create(:restaurant, :with_menus) }
  let(:valid_attributes) { { restaurant: { name: "New Restaurant" } } }
  let(:invalid_attributes) { { restaurant: { name: "" } } }

  describe 'GET /api/v1/restaurants' do
    before { get api_v1_restaurants_path }

    it 'returns correct structure with menus and items' do
      parsed = JSON.parse(response.body)
      first_restaurant = parsed.first
      expect(response).to have_http_status(:ok)

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
      expect(response).to have_http_status(:ok)
      expect(parsed['menus'].size).to eq(2)

      first_menu = parsed['menus'].first
      expect(first_menu['menu_items'].size).to eq(3)
      expect(first_menu['menu_items'].first).to include('id', 'name', 'price')
    end
  end

  describe 'POST /api/v1/restaurants' do
    before { post api_v1_restaurants_path, params: valid_attributes }

    it 'creates a new restaurant' do
      parsed = JSON.parse(response.body)

      expect(Restaurant.count).to eq(2) # 1 from let!(:restaurant) + 1 new
      expect(response).to have_http_status(:created)
      expect(parsed['name']).to eq('New Restaurant')
    end
  end

  describe 'Error Handling' do
    context 'when restaurant does not exist' do
      before { get api_v1_restaurant_path(id: 0) }

      it 'returns 404 status' do
        expect(response).to have_http_status(:not_found)
      end
    end

    context 'tries to create a restaurant with invalid parameters' do
      before { post api_v1_restaurants_path, params: invalid_attributes }

      it 'does not create a new restaurant' do
        parsed = JSON.parse(response.body)

        expect(Restaurant.count).to eq(1)  # 1 from let!(:restaurant) + 0 from invalid POST
        expect(response).to have_http_status(:unprocessable_entity)
        expect(parsed['errors']).to be_present
        expect(parsed['errors']).to include("Name can't be blank")
      end
    end
  end
end
