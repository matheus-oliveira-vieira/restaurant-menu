class Api::V1::MenuItemsController < ApplicationController
  rescue_from ActiveRecord::RecordNotFound, with: :not_found

  def show
    item = MenuItem.find(params[:id])
    render json: item, status: :ok
  end

  def create
    restaurant = Restaurant.find(params[:restaurant_id])
    menu = restaurant.menus.find(params[:menu_id])
    item = restaurant.menu_items.new(menu_item_params)
    if item.save
      item.menus << menu unless item.menus.include?(menu)
      render json: item, status: :created
    else
      render json: { errors: item.errors.full_messages }, status: :unprocessable_entity
    end
  end

  private

  def menu_item_params
    params.require(:menu_item).permit(:name, :price)
  end

  def not_found(e)
    render json: {
      error: "Record not found",
      details: e.message
    }, status: :not_found
  end
end
