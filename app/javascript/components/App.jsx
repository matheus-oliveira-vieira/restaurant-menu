import React, { useState } from "react";
import RestaurantList from "./RestaurantList";
import RestaurantDetail from "./RestaurantDetail";

const App = () => {
  const [selectedRestaurantId, setSelectedRestaurantId] = useState(null);

  return (
    <div className="min-h-screen bg-gray-100 p-6">
      <div className="max-w-4xl mx-auto bg-white p-6 rounded-lg shadow-md">
        <h1 className="text-4xl font-bold text-center text-indigo-600 mb-8">Restaurant Menu App</h1>
        {!selectedRestaurantId ? (
          <RestaurantList onSelect={setSelectedRestaurantId} />
        ) : (
          <RestaurantDetail restaurantId={selectedRestaurantId} onBack={() => setSelectedRestaurantId(null)} />
        )}
      </div>
    </div>
  );
};

export default App;