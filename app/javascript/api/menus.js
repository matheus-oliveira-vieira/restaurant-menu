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

export async function createMenu(restaurantId, data) {
  const response = await fetch(`/api/v1/restaurants/${restaurantId}/menus`, {
    method: "POST",
    headers: { "Content-Type": "application/json" },
    body: JSON.stringify({ menu: data }),
  });

  if (!response.ok) throw new Error("Error creating menu");
  return response.json();
}

export async function updateMenu(id, data) {
  const response = await fetch(`/api/v1/menus/${id}`, {
    method: "PUT",
    headers: { "Content-Type": "application/json" },
    body: JSON.stringify({ menu: data }),
  });

  if (!response.ok) throw new Error("Erro updating menu");
  return response.json();
}
