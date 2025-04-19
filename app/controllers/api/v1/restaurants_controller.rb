class Api::V1:: RestaurantsController < ApplicationController
  rescue_from ActiveRecord::RecordNotFound, with: :not_found

  def index
    @restaurants = Restaurant.includes(menus: :menu_items)
    render json: @restaurants, include: { menus: { include: :menu_items } }, status: :ok
    # Renders all menus from each restaurant and all menu items direct from the restaurant
  end

  def show
    @restaurant = Restaurant.find(params[:id])
    render json: @restaurant, include: { menus: { include: :menu_items } }, status: :ok
  end

  private

  def not_found(e)
    render json: {
      error: "Record not found",
      details: e.message
    }, status: :not_found
  end
end
