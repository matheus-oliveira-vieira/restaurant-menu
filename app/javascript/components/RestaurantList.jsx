import React, { useEffect, useState } from "react";
import { fetchRestaurants } from "../api/restaurants";

const RestaurantList = ({ onSelect }) => {
  const [restaurants, setRestaurants] = useState([]);

  useEffect(() => {
    fetchRestaurants().then(setRestaurants).catch(console.error);
  }, []);

  return (
    <div>
      <h2 className="text-2xl font-semibold mb-4">Restaurants</h2>
      <ul className="space-y-3">
        {restaurants.map((r) => (
          <li key={r.id}>
            <button
              className="w-full text-left bg-indigo-500 hover:bg-indigo-600 text-white px-4 py-3 rounded shadow"
              onClick={() => onSelect(r.id)}
            >
              {r.name}
            </button>
          </li>
        ))}
      </ul>
    </div>
  );
};

export default RestaurantList;
