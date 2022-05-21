class InventoriesController < ApplicationController
  before_action :authenticate_user!
  load_and_authorize_resource

  def index
    @inventories = Inventory.where(user_id: current_user.id)
  end

  def show
    @inventory = Inventory.find_by(id: params[:id])
    @inventory_foods = InventoryFood.where(inventory_id: params[:id]).includes([:food])
  end

  def new
    @inventory = Inventory.new
  end

  def create
    @inventory = Inventory.new(inventory_params)

    if @inventory.save
      redirect_to inventories_path, notice: 'Successfully created Inventory.'
    else
      render :new, alert: 'Could not create inventory.'
    end
  end

  def destroy
    @inventory = Inventory.destroy(params[:id])

    if @inventory.destroyed?
      redirect_to inventories_path, notice: 'Successfully deleted inventory.'
    else
      render :new, alert: 'Could not delete inventory.'
    end
  end

  private

  def inventory_params
    inventory_hash = params.require(:inventory).permit(:name, :description)
    inventory_hash[:user] = current_user
    inventory_hash
  end
end
