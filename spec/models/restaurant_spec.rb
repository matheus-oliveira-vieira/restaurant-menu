require 'rails_helper'

describe Restaurant do
  describe 'associations' do
    it { is_expected.to have_many(:menus) }
    it { is_expected.to have_many(:menu_items) }
  end
end
