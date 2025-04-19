class CreateMenusMenuItemsJoinTable < ActiveRecord::Migration[8.0]
  def change
    create_join_table :menus, :menu_items do |t|
      t.index [ :menu_id, :menu_item_id ], unique: true
      t.timestamps
    end
  end
end
