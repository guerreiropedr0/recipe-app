class InventoriesController < ApplicationController
  before_action :authenticate_user!
  load_and_authorize_resource

  def index
    if current_user
      @inventories = Inventory.where(user_id: current_user.id)
    else
      flash[:alert] = 'You need to log in as a user for you to access your inventries!'
    end
  end

  def new; end

  def create
    @inventory = Inventory.new(inventory_params)
    if @inventory.valid?
      @inventory.save
      @inventories = Inventory.where(user_id: current_user.id)
      render :index
    else
      redirect_to new_inventory_path
    end
  end

  def destroy
    redirect_to inventories_path, notice: 'Successfully deleted inventory!' if Inventory.destroy(params[:id])
  end

  private

  def inventory_params
    params.require(:inventory).permit(:name, :description, :user_id)
  end
end
