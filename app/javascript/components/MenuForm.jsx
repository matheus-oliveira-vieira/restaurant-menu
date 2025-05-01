import React, { useState } from "react";
import { createMenu } from "../api/menus";

const MenuForm = ({ restaurantId, onCreated }) => {
  const [name, setName] = useState("");
  const [loading, setLoading] = useState(false);
  const [error, setError] = useState(null);

  const handleSubmit = async (e) => {
    e.preventDefault();
    setLoading(true);
    setError(null);
    try {
      const menu = await createMenu(restaurantId, { name });
      setName("");
      onCreated(menu);
    } catch (err) {
      setError("Error creating menu");
    } finally {
      setLoading(false);
    }
  };

  return (
    <form onSubmit={handleSubmit} className="mb-4 space-y-4">
      <input
        type="text"
        placeholder="Menu Name"
        className="w-full border border-gray-300 p-2 rounded"
        value={name}
        onChange={(e) => setName(e.target.value)}
        required
      />
      {error && <p className="text-red-600">{error}</p>}
      <button
        type="submit"
        disabled={loading}
        className="bg-indigo-600 text-white px-4 py-2 rounded hover:bg-indigo-700"
      >
        {loading ? "Saving..." : "Add Menu"}
      </button>
    </form>
  );
};

export default MenuForm;
