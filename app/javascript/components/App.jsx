import React, { useState } from "react";
import RestaurantList from "./RestaurantList";
import RestaurantDetail from "./RestaurantDetail";

const App = () => {
  const [selectedRestaurantId, setSelectedRestaurantId] = useState(null);

  return (
    <div className="p-4">
      <h1 className="text-2xl font-bold">Restaurant Menu App</h1>
      {!selectedRestaurantId ? (
        <RestaurantList onSelect={setSelectedRestaurantId} />
      ) : (
        <RestaurantDetail restaurantId={selectedRestaurantId} onBack={() => setSelectedRestaurantId(null)} />
      )}
    </div>
  );
};

export default App;