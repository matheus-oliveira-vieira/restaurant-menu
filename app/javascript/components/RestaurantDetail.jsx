import React, { useEffect, useState } from "react";
import { fetchRestaurant } from "../api/restaurants";
import MenuForm from "./MenuForm";
import MenuItemForm from "./MenuItemForm";

const RestaurantDetail = ({ restaurantId, onBack }) => {
  const [restaurant, setRestaurant] = useState(null);

  useEffect(() => {
    fetchRestaurant(restaurantId).then(setRestaurant).catch(console.error);
  }, [restaurantId]);

  const handleMenuCreated = (newMenu) => {
    setRestaurant((prev) => ({
      ...prev,
      menus: [...prev.menus, { ...newMenu, menu_items: [] }],
    }));
  };

  const handleMenuItemCreated = (menuId, newItem) => {
    setRestaurant((prev) => ({
      ...prev,
      menus: prev.menus.map((menu) =>
        menu.id === menuId
          ? { ...menu, menu_items: [...menu.menu_items, newItem] }
          : menu
      ),
    }));
  };

  if (!restaurant) return <p>Loading...</p>;

  return (
    <div>
      <button
        onClick={onBack}
        className="text-indigo-600 hover:underline mb-4"
      >
        Back
      </button>
      <h2 className="text-3xl font-bold text-gray-800 mb-6">{restaurant.name}</h2>

      <div className="mb-8">
        <h3 className="text-xl font-semibold mb-2">Add New Menu</h3>
        <MenuForm restaurantId={restaurant.id} onCreated={handleMenuCreated} />
      </div>

      {restaurant.menus.map((menu) => (
        <div
          key={menu.id}
          className="mb-6 border rounded-lg shadow-sm p-4 bg-gray-50"
        >
          <h3 className="text-xl font-semibold text-gray-700 mb-2">
            {menu.name}
          </h3>
          <ul className="list-disc list-inside space-y-1 mb-4">
            {menu.menu_items.map((item) => (
              <li key={item.id} className="text-gray-600">
                {item.name} - <span className="font-medium text-gray-800">${" "}
                {Number(item.price).toFixed(2)}</span>
              </li>
            ))}
          </ul>
          <MenuItemForm
            menuId={menu.id}
            restaurantId={restaurant.id}
            onCreated={(item) => handleMenuItemCreated(menu.id, item)}
          />
        </div>
      ))}
    </div>
  );
};

export default RestaurantDetail;
