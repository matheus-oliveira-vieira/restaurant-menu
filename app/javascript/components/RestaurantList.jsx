import React, { useEffect, useState } from "react";
import { fetchRestaurants } from "../api/restaurants";

const RestaurantList = ({ onSelect }) => {
  const [restaurants, setRestaurants] = useState([]);

  useEffect(() => {
    fetchRestaurants().then(setRestaurants).catch(console.error);
  }, []);

  return (
    <div>
      <h2>Restaurants</h2>
      <ul>
        {restaurants.map((r) => (
          <li key={r.id}>
            <button onClick={() => onSelect(r.id)}>{r.name}</button>
          </li>
        ))}
      </ul>
    </div>
  );
};

export default RestaurantList;
