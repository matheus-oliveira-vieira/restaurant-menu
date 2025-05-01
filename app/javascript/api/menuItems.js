export async function fetchMenuItem(menuItemId) {
  const response = await fetch(`/api/v1/menu_items/${menuItemId}`);
  if (!response.ok) throw new Error("Error loading menu item");
  return await response.json();
}

export async function createMenuItem(restaurantId, menuId, data) {
  const response = await fetch(`/api/v1/restaurants/${restaurantId}/menus/${menuId}/menu_items`, {
    method: "POST",
    headers: { "Content-Type": "application/json" },
    body: JSON.stringify({ menu_item: data }),
  });

  if (!response.ok) throw new Error("Error creating menu item");
  return await response.json();
}

export async function updateMenuItem(id, data) {
  const response = await fetch(`/api/v1/menu_items/${id}`, {
    method: "PUT",
    headers: { "Content-Type": "application/json" },
    body: JSON.stringify({ menu_item: data }),
  });
  if (!response.ok) throw new Error("Error updating menu item");
  return response.json();
}


