class Api::V1::MenuItemsController < ApplicationController
  rescue_from ActiveRecord::RecordNotFound, with: :not_found

  def show
    item = MenuItem.find(params[:id])
    render json: item, status: :ok
  end

  def create
    item = MenuItem.new(menu_item_params)
    if item.save
      render json: item, status: :created
    else
      render json: { errors: item.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def update
    item = MenuItem.find(params[:id])
    if item.update(menu_item_params)
      render json: item, status: :ok
    else
      render json: { errors: item.errors.full_messages }, status: :unprocessable_entity
    end
  end

  private

  def menu_item_params
    params.require(:menu_item).permit(:name, :price, :restaurant_id)
  end

  def not_found(e)
    render json: {
      error: "Record not found",
      details: e.message
    }, status: :not_found
  end
end
