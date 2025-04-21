class JsonImporter
  def self.call(data)
    new(data).call
  end

  def initialize(data)
    @data = data
    @logs = []
  end

  def call
    @data["restaurants"].each do |restaurant_data|
      restaurant = Restaurant.find_or_create_by!(name: restaurant_data["name"])
      @logs << "Importing restaurant: #{restaurant.name}"

      restaurant_data["menus"].each do |menu_data|
        menu = restaurant.menus.find_or_create_by!(name: menu_data["name"])
        @logs << "Menu: #{menu.name}"

        items = menu_data["menu_items"] || menu_data["dishes"] || []
        items.each do |item_data|
          menu_item = MenuItem.where(name: item_data["name"], restaurant_id: restaurant.id).first_or_initialize
          menu_item.price ||= item_data["price"]
          menu_item.restaurant = restaurant
          menu_item.save!

          if menu.menu_items.exists?(menu_item.id)
            @logs << "Skipped duplicate item: #{menu_item.name}"
          else
            menu.menu_items << menu_item
            @logs << "Added item: #{menu_item.name} (#{menu_item.price})"
          end
        end
      end
    end
    @logs
  end
end
