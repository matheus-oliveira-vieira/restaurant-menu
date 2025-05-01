import React, { useState } from "react";
import { createMenuItem } from "../api/menuItems";

const MenuItemForm = ({ restaurantId, menuId, onCreated }) => {
  const [name, setName] = useState("");
  const [price, setPrice] = useState("");
  const [loading, setLoading] = useState(false);
  const [error, setError] = useState(null);

  const handleSubmit = async (e) => {
    e.preventDefault();
    setLoading(true);
    setError(null);

    try {
      const newItem = await createMenuItem(
        restaurantId,
        menuId,
        {
          name,
          price: parseFloat(price),
        }
      );

      setName("");
      setPrice("");
      onCreated(newItem);
    } catch (err) {
      setError("Error creating menu item");
    } finally {
      setLoading(false);
    }
  };

  return (
    <form onSubmit={handleSubmit} className="mb-4 space-y-4">
      <input
        type="text"
        placeholder="Item name"
        className="w-full border border-gray-300 p-2 rounded"
        value={name}
        onChange={(e) => setName(e.target.value)}
        required
      />
      <input
        type="number"
        step="0.01"
        placeholder="Price"
        className="w-full border border-gray-300 p-2 rounded"
        value={price}
        onChange={(e) => setPrice(e.target.value)}
        required
      />
      {error && <p className="text-red-600">{error}</p>}
      <button
        type="submit"
        disabled={loading}
        className="bg-green-600 text-white px-4 py-2 rounded hover:bg-green-700"
      >
        {loading ? "Saving..." : "Add Item"}
      </button>
    </form>
  );
};

export default MenuItemForm;
