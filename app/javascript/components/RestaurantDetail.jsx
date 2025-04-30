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
      <button onClick={onBack}>← Voltar</button>
      <h2 className="text-xl font-bold">{restaurant.name}</h2>

      {restaurant.menus.map((menu) => (
        <div key={menu.id} className="border p-2 my-2">
          <h3 className="font-semibold">{menu.name}</h3>
          <ul className="list-disc ml-4">
            {menu.menu_items.map((item) => (
              <li key={item.id}>
                {item.name} - R$ {(item.price / 100).toFixed(2)}
              </li>
            ))}
          </ul>
        </div>
      ))}
    </div>
  );
};

export default RestaurantDetail;
