require 'rails_helper'

describe MenuItem do
  context 'associations' do
    it { should belong_to(:menu) }
  end

  context 'validations' do
    it { should validate_presence_of(:name) }
    it { should validate_numericality_of(:price).is_greater_than_or_equal_to(0) }
  end

  context "create menuItem" do
    let(:menu_item) { create(:menu_item) }

    it "successfully" do
      expect(menu_item).to be_valid
    end
  end
end
