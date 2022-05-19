class RecipesController < ApplicationController
  def index
    if current_user
      @recipes = Recipe.where(user_id: current_user.id)
    else
      flash[:alert] = 'You need to login in order to see your recipes.'
    end
  end

  def show
    @recipe = Recipe.find_by(id: params[:id])
  end

  def new
    if current_user
      @recipe = Recipe.new
      @foods = Food.all
    else
      redirect_to root_path, alert: 'You need to login in order to create a recipe.'
    end
  end

  def create
    @recipe = Recipe.new(recipe_params)

    if @recipe.save
      selected_foods = params[:recipe][:foods]
      selected_foods.each_with_index do |food_id, index|
        next if index.zero?

        RecipeFood.add_food(@recipe.id, food_id, 1)
      end
      redirect_to recipes_path, notice: 'Successfully created recipe.'
    else
      flash.now[:alert] = 'Could not create recipe.'
      render :new
    end
  end

  def destroy
    redirect_to root_path, notice: 'Successfully deleted recipe.' if Recipe.destroy(params[:id])
  end

  def public_recipes
    @recipes = Recipe.where(public: true).order(created_at: :desc)
  end

  private

  def recipe_params
    recipe_hash = params.require(:recipe).permit(:name, :description, :cooking_time, :preparation_time, :public)
    recipe_hash[:user] = current_user
    recipe_hash
  end
end
