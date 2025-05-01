export async function createMenuItem(restaurantId, menuId, data) {
  const response = await fetch(`/api/v1/restaurants/${restaurantId}/menus/${menuId}/menu_items`, {
    method: "POST",
    headers: { "Content-Type": "application/json" },
    body: JSON.stringify({ menu_item: data }),
  });

  if (!response.ok) throw new Error("Error creating menu item");
  return await response.json();
}


