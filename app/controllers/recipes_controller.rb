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
    else
      redirect_to root_path, alert: 'You need to login in order to create a recipe.'
    end
  end

  def create
    @recipe = Recipe.new(recipe_params)

    if @recipe.save
      redirect_to recipes_path, notice: 'Successfully created recipe.'
    else
      render :new, alert: 'Could not create recipe.'
    end
  end

  def destroy
    @recipe = Recipe.destroy(params[:id])

    if @recipe.destroyed?
      redirect_to recipes_path, notice: 'Successfully deleted recipe.'
    else
      render :new, alert: 'Could not delete recipe.'
    end
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
