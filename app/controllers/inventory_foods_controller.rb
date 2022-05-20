class InventoryFoodsController < ApplicationController
  def new
    @inventory_food = InventoryFood.new
    @foods = Food.where(user_id: current_user.id)
  end

  def create
    @inventory_food = InventoryFood.new(food_id: params[:food][:food_id], inventory_id: params[:inventory_id],
                                        quantity: params[:quantity])

    if @inventory_food.save
      redirect_to inventories_path, notice: 'Successfully added a Food.'
    else
      render :new, alert: 'Something went wrong!.'
    end
  end
end
