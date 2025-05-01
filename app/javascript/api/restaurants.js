export async function fetchRestaurants() {
  const response = await fetch("/api/v1/restaurants");
  if (!response.ok) throw new Error("Error loading restaurants");
  return await response.json();
}

export async function fetchRestaurant(id) {
  const response = await fetch(`/api/v1/restaurants/${id}`);
  if (!response.ok) throw new Error("Error loading restaurant");
  return await response.json();
}

export async function createRestaurant(data) {
  const response = await fetch("/api/v1/restaurants", {
    method: "POST",
    headers: { "Content-Type": "application/json" },
    body: JSON.stringify({ restaurant: data }),
  });

  if (!response.ok) throw new Error("Error creating restaurant");
  return response.json();
}

export async function updateRestaurant(id, data) {
  const response = await fetch(`/api/v1/restaurants/${id}`, {
    method: "PUT",
    headers: { "Content-Type": "application/json" },
    body: JSON.stringify({ restaurant: data }),
  });

  if (!response.ok) throw new Error("Error updating restaurant");
  return response.json();
}