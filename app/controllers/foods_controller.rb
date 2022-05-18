class FoodsController < ApplicationController
  def index
    @foods = Food.where(user: current_user)
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
    @food = Food.find(params[:id])
    @food.destroy
    respond_to do |format|
      if @food.nil?
        format.html { redirect_to foods_path, status: :success, notice: 'Food successfully deleted!' }
      else
        format.html { redirect_to foods_path, alert: 'Food is not deleted!' }
      end
    end
  end

  private

  def food_params
    food_hash = params.require(:food).permit(:name, :measurement_unit, :price)
    food_hash[:user] = current_user
    food_hash
  end
end
