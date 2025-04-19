require 'rails_helper'

describe MenuItem do
  describe 'associations' do
    it { should belong_to(:restaurant) }
    it { should have_and_belong_to_many(:menus) }
  end

  describe 'validations' do
    it { should validate_presence_of(:name) }
    it { should validate_numericality_of(:price).is_greater_than_or_equal_to(0) }

    context 'uniqueness scoped to restaurant' do
      let!(:restaurant) { create(:restaurant) }
      let!(:existing_item) { create(:menu_item, name: 'Cupcake', restaurant: restaurant) }

      it 'does not allow items with the same name in the same restaurant' do
        new_item = build(:menu_item, name: 'Cupcake', restaurant: restaurant)
        expect(new_item).not_to be_valid
        expect(new_item.errors[:name]).to include('has already been taken')
      end

      it 'allow items with the same name in different restaurants' do
        other_restaurant = create(:restaurant)
        new_item = build(:menu_item, name: 'Cupcake', restaurant: other_restaurant)
        expect(new_item).to be_valid
      end
    end
  end

  describe 'behavior' do
    let!(:restaurant) { create(:restaurant) }
    let!(:menu1) { create(:menu, restaurant: restaurant) }
    let!(:menu2) { create(:menu, restaurant: restaurant) }

    it 'create a valid menu item' do
      expect(create(:menu_item, restaurant: restaurant)).to be_valid
    end

    it 'item can be on multiple menus at the same restaurant' do
      item = create(:menu_item, restaurant: restaurant, menus: [ menu1, menu2 ])
      expect(item.menus).to contain_exactly(menu1, menu2)
    end

    it 'does not appear on other restaurant menus' do
      other_restaurant = create(:restaurant)
      other_menu = create(:menu, restaurant: other_restaurant)
      item = create(:menu_item, restaurant: restaurant, menus: [ menu1 ])

      expect(item.menus).not_to include(other_menu)
      expect(other_menu.menu_items).not_to include(item)
    end
  end
end
