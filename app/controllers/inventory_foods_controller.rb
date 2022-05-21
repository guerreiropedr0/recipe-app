class InventoryFoodsController < ApplicationController
  def new
    @inventory_food = InventoryFood.new
  end
end
