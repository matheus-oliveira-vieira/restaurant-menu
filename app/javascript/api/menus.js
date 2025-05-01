export async function createMenu(restaurantId, data) {
  const response = await fetch(`/api/v1/restaurants/${restaurantId}/menus`, {
    method: "POST",
    headers: { "Content-Type": "application/json" },
    body: JSON.stringify({ menu: data }),
  });

  if (!response.ok) throw new Error("Error creating menu");
  return response.json();
}
