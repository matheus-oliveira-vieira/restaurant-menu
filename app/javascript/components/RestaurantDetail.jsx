import React, { useEffect, useState } from "react";
import { fetchRestaurant } from "../api/restaurants";

const RestaurantDetail = ({ restaurantId, onBack }) => {
  const [restaurant, setRestaurant] = useState(null);

  useEffect(() => {
    fetchRestaurant(restaurantId).then(setRestaurant).catch(console.error);
  }, [restaurantId]);

  if (!restaurant) return <p>Loading...</p>;

  return (
    <div>
      <button onClick={onBack} className="text-indigo-600 hover:underline mb-4">Voltar</button>
      <h2 className="text-3xl font-bold text-gray-800 mb-6">{restaurant.name}</h2>

      {restaurant.menus.map((menu) => (
        <div key={menu.id} className="mb-6 border rounded-lg shadow-sm p-4 bg-gray-50">
          <h3 className="text-xl font-semibold text-gray-700 mb-2">{menu.name}</h3>
          <ul className="list-disc list-inside space-y-1">
            {menu.menu_items.map((item) => (
              <li key={item.id} className="text-gray-600">
                {item.name} - <span className="font-medium text-gray-800">$ {Number(item.price).toFixed(2)}</span>
              </li>
            ))}
          </ul>
        </div>
      ))}
    </div>
  );
};

export default RestaurantDetail;
