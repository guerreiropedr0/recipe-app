class InventoryFoodsController < ApplicationController
  def new
    @inventory = Inventory.find_by(id: params[:inventory_id])
    @inventory_food = InventoryFood.new
  end

  def create
    @inventory_food = InventoryFood.new(food_id: params[:food][:food_id], inventory_id: params[:inventory_id],
                                        quantity: params[:quantity])

    if @inventory_food.save
      redirect_to inventory_path(@inventory_food.inventory_id), notice: 'Successfully added a food.'
    else
      render :new, alert: 'Something happened.'
    end
  end

  def destroy
    @inventory_food = InventoryFood.destroy(params[:id])

    if @inventory_food.destroyed?
      redirect_to inventories_path, notice: 'Successfully deleted food.'
    else
      render :new, alert: 'Could not delete food.'
    end
  end
end
