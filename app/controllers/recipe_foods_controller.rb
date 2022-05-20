class RecipeFoodsController < ApplicationController
  before_action :authenticate_user!

  def new
    @recipe = Recipe.find_by(id: params[:recipe_id])
    @recipe_food = RecipeFood.new
    @foods = Food.where(user_id: current_user.id)
  end

  def create
    @recipe_food = RecipeFood.new(food_id: params[:food][:food_id], recipe_id: params[:recipe_id],
                                  quantity: params[:quantity])

    if @recipe_food.save
      redirect_to recipes_path, notice: 'Successfully added an ingredient.'
    else
      render :new, alert: 'Something happened.'
    end
  end
end
