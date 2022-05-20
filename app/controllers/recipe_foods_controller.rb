class RecipeFoodsController < ApplicationController
  before_action :authenticate_user!

  def new
    @recipe = Recipe.find_by(id: params[:recipe_id])
    @recipe_food = RecipeFood.new
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

  def edit
    @recipe_food = RecipeFood.find_by(id: params[:id])
  end

  def update
    @recipe_food = RecipeFood.find_by(id: params[:id])
    if @recipe_food.update(recipe_food_params)
      redirect_to recipe_path(params[:recipe_id]), notice: 'Successfully modified food quantity.'
    else
      render :new, alert: 'Could not modify food quantity'
    end
  end

  def destroy
    @recipe_food = RecipeFood.destroy(params[:id])

    if @recipe_food.destroyed?
      redirect_to recipes_path, notice: 'Successfully deleted ingredient.'
    else
      render :new, alert: 'Could not delete ingredient.'
    end
  end

  private

  def recipe_food_params
    params.require(:recipe_food).permit(:quantity)
  end
end
