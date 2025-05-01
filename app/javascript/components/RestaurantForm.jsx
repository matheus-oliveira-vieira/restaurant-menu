import React, { useState } from "react";
import { createRestaurant } from "../api/restaurants";

const RestaurantForm = ({ onCreated }) => {
  const [name, setName] = useState("");
  const [loading, setLoading] = useState(false);
  const [error, setError] = useState(null);

  const handleSubmit = async (e) => {
    e.preventDefault();
    setLoading(true);
    setError(null);

    try {
      const newRestaurant = await createRestaurant({ name });
      onCreated(newRestaurant);
      setName("");
    } catch (err) {
      setError("Error creating restaurant");
    } finally {
      setLoading(false);
    }
  };

  return (
    <form onSubmit={handleSubmit} className="mb-4 flex items-center gap-4">
      <input
        type="text"
        placeholder="Restaurant name"
        value={name}
        onChange={(e) => setName(e.target.value)}
        required
        className="flex-grow border border-gray-300 p-2 rounded"
      />
      <button
        type="submit"
        disabled={loading}
        className="bg-indigo-600 text-white px-4 py-2 rounded hover:bg-indigo-700"
      >
        {loading ? "Creating..." : "Add"}
      </button>
      {error && <p className="text-red-600 text-sm">{error}</p>}
    </form>
  );
};

export default RestaurantForm;
