class FoodsController < ApplicationController
  before_action :authenticate_user!
  load_and_authorize_resource

  def index
    @foods = Food.all
  end

  def show
    @food = Food.find(params[:id])
  end

  def new
    @food = Food.new
  end

  def create
    @food = Food.new(food_params)

    respond_to do |format|
      if @food.save
        format.html { redirect_to foods_path, notice: 'Food created successfully!' }
      else
        format.html { render action: 'new', alert: 'Something went wrong! Food was not created!' }
      end
    end
  end

  def destroy
    @food = Food.find(params[:id]).destroy

    if @food.destroyed?
      redirect_to foods_path, notice: 'Food successfully deleted!'
    else
      redirect_to foods_path, alert: 'Food is not deleted!'
    end
  end

  private

  def food_params
    food_hash = params.require(:food).permit(:name, :measurement_unit, :price)
    food_hash[:user] = current_user
    food_hash
  end
end
