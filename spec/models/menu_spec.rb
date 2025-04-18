require 'rails_helper'

describe Menu do
  context 'associations' do
    it { should have_many(:menu_items) }
  end

  context 'validations' do
    it { should validate_presence_of(:name) }
  end

  describe 'behaviour' do
    let(:menu) { create(:menu) }

    it 'allow to add items' do
      expect(menu).to be_valid
      expect do
        menu.menu_items.create!(name: 'Bread', price: 5.0)
      end.to change(menu.menu_items, :count).by(1)
    end
  end
end
