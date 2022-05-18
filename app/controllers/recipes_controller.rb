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

  def new; end

  def create; end

  def destroy
    redirect_to root_path, notice: 'Successfully deleted recipe.' if Recipe.destroy(params[:id])
  end

  def public_recipes; end
end
