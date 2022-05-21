class InventoriesController < ApplicationController
  before_action :authenticate_user!
  load_and_authorize_resource

  def index
    if current_user
      @inventory = Inventory.where(user_id: current_user.id)
    else
      flash[:alert] = 'You need to log in as a user for you to access your inventries!'
    end
  end

  def show
    @inventory = Inventory.find_by(id: params[:id])
    @inventory_foods = InventoryFood.where(inventory_id: params[:id]).includes([:food])
  end

  def new; end

  def create; end

  def destroy; end
end
