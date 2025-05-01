import React, { useEffect, useState } from "react";
import { fetchRestaurants } from "../api/restaurants";
import RestaurantForm from "./RestaurantForm";

const RestaurantList = ({ onSelect }) => {
  const [restaurants, setRestaurants] = useState([]);

  useEffect(() => {
    loadRestaurants();
  }, []);

  const loadRestaurants = async () => {
    try {
      const data = await fetchRestaurants();
      setRestaurants(data);
    } catch (err) {
      console.error("Error loading restaurants", err);
    }
  };

  const handleCreated = (newRestaurant) => {
    setRestaurants((prev) => [...prev, newRestaurant]);
  };

  return (
    <div>
      <h2 className="text-2xl font-semibold mb-4">Restaurants</h2>
      <RestaurantForm onCreated={handleCreated} />
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
