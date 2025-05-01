class Api::V1::MenusController < ApplicationController
  rescue_from ActiveRecord::RecordNotFound, with: :not_found

  def index
    @restaurant = Restaurant.find(params[:restaurant_id])
    @menus = @restaurant.menus.includes(:menu_items) # Loads all restaurant menus with their items
    render json: @menus, include: :menu_items, status: :ok # Include associated menu items in the output JSON
  end

  def show
    @menu = Menu.find(params[:id])
    render json: @menu, include: :menu_items, status: :ok
  end

  def create
    restaurant = Restaurant.find(params[:restaurant_id])
    menu = restaurant.menus.new(menu_params)
    if menu.save
      render json: menu, status: :created
    else
      render json: { errors: menu.errors.full_messages }, status: :unprocessable_entity
    end
  end

  private

  def menu_params
    params.require(:menu).permit(:name, menu_item_ids: [])
  end

  def not_found(e)
    render json: {
      error: "Record not found",
      details: e.message
    }, status: :not_found
  end
end
