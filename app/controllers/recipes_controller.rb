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
    @recipe.user = current_user

    if @recipe.save
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
end
