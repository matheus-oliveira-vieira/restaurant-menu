class MenuItem < ApplicationRecord
  belongs_to :restaurant
  has_and_belongs_to_many :menus # N:N relation

  validates :name, presence: true
  validates :name, uniqueness: { scope: :restaurant_id } # Unique name per restaurant
  validates :price, numericality: { greater_than_or_equal_to: 0 }
end
