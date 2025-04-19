class Menu < ApplicationRecord
  belongs_to :restaurant
  has_and_belongs_to_many :menu_items # N:N relation

  validate :menu_items_belong_to_same_restaurant # Checks if all associated menu items belong to the same restaurant as the menu
  validates :name, presence: true

  private

  def menu_items_belong_to_same_restaurant
    menu_items.each do |item|
      unless item.restaurant_id == restaurant_id
        errors.add(:menu_items, "must belong to the same restaurant")
        break
      end
    end
  end
end
