class RecipesController < ApplicationController
  before_action :authenticate_user!, only: %i[index new create destroy]

  load_and_authorize_resource

  def index
    @recipes = Recipe.where(user_id: current_user&.id)
  end

  def show
    @recipe = Recipe.find_by(id: params[:id])
  end

  def new
    @recipe = Recipe.new
    @foods = Food.all
  end

  def create
    @recipe = Recipe.new(recipe_params)

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

  private

  def recipe_params
    recipe_hash = params.require(:recipe).permit(:name, :description, :cooking_time, :preparation_time, :public)
    recipe_hash[:user] = current_user
    recipe_hash
  end
end
