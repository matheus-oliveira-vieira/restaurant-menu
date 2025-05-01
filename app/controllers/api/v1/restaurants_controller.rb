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

  def create
    restaurant = Restaurant.new(restaurant_params)
    if restaurant.save
      render json: restaurant, status: :created
    else
      render json: { errors: restaurant.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def update
    restaurant = Restaurant.find(params[:id])
    if restaurant.update(restaurant_params)
      render json: restaurant, status: :ok
    else
      render json: { errors: restaurant.errors.full_messages }, status: :unprocessable_entity
    end
  end

  private

  def restaurant_params
    params.require(:restaurant).permit(:name)
  end

  def not_found(e)
    render json: {
      error: "Record not found",
      details: e.message
    }, status: :not_found
  end
end
