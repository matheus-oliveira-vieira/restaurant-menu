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

  private

  def not_found(e)
    render json: {
      error: "Record not found",
      details: e.message
    }, status: :not_found
  end
end
