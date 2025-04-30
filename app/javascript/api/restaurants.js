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