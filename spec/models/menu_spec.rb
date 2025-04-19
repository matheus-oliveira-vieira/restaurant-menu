require 'rails_helper'

describe Menu do
  describe 'associations' do
    it { should belong_to(:restaurant) }
    it { should have_and_belong_to_many(:menu_items) }
  end

  describe 'validations' do
    it { should validate_presence_of(:name) }
  end

  describe 'behavior' do
    let!(:restaurant) { create(:restaurant) }
    let!(:menu) { create(:menu, restaurant: restaurant) }

    context 'when items are added' do
      it 'allows to add existing items from the same restaurant' do
        item = create(:menu_item, restaurant: restaurant)
        expect {
          menu.menu_items << item
        }.to change(menu.menu_items, :count).by(1)
      end

      it 'does not allow items from other restaurant' do
        other_restaurant = create(:restaurant)
        foreign_item = create(:menu_item, restaurant: other_restaurant)

        menu.menu_items << foreign_item
        expect(menu).not_to be_valid
        expect(menu.errors[:menu_items]).to include("must belong to the same restaurant")
      end

      it 'does not allow associating the same item multiple times to the same menu' do
        item = create(:menu_item, restaurant: restaurant)
        menu.menu_items << item
        expect { menu.menu_items << item }.to raise_error(ActiveRecord::RecordNotUnique)
      end

      it 'allows items from the same restaurant' do
        valid_item = create(:menu_item, restaurant: menu.restaurant)
        expect {
          menu.menu_items << valid_item
        }.to change(menu.menu_items, :count).by(1)
        expect(menu).to be_valid
      end
    end

    context 'scopes' do
      let!(:item) { create(:menu_item, restaurant: restaurant) }

      it 'does not allow duplicating items in the same menu' do
        # First association should work
        menu.menu_items << item
        expect(menu.menu_items.count).to eq(1)

        # Second attempt must fail
        expect {
          menu.menu_items << item
        }.to raise_error(ActiveRecord::RecordNotUnique)
      end

      it 'allows the same item in different menus' do
        menu2 = create(:menu, restaurant: restaurant)

        menu.menu_items << item
        menu2.menu_items << item

        expect(menu.menu_items).to include(item)
        expect(menu2.menu_items).to include(item)
        expect(item.menus).to contain_exactly(menu, menu2)
      end
    end
  end
end
