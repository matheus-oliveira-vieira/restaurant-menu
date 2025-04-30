export async function fetchMenusByRestaurant(restaurantId) {
  const response = await fetch(`/api/v1/restaurants/${restaurantId}/menus`);
  if (!response.ok) throw new Error("Error loading menus");
  return await response.json();
}

export async function fetchMenu(menuId) {
  const response = await fetch(`/api/v1/menus/${menuId}`);
  if (!response.ok) throw new Error("Error loading menu");
  return await response.json();
}