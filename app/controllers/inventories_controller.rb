class InventoriesController < ApplicationController
  def index
    if current_user
      @inventories = Inventory.where(user_id: current_user.id)
    else
      flash[:alert] = 'You need to log in as a user for you to access your inventries!'
    end
  end

  def show; end

  def new; end

  def create; end

  def destroy
    redirect_to root_path, notice: 'Successfully deleted inventory!' if Inventory.destroy(params[:id])
  end
end
