require 'rails_helper'

describe 'Menus' do
  let!(:menu) { create(:menu, :with_items) }

  describe 'GET /api/v1/menus' do
    before { get api_v1_menus_path }

    it 'successfully' do
      expect(response).to have_http_status(:ok)
    end

    it 'return menus with items' do
      parsed_response = JSON.parse(response.body)
      expect(parsed_response.first['name']).to eq(menu.name)
      expect(parsed_response.first['menu_items'].first['name']).to eq(menu.menu_items.first.name)
    end
  end
end
