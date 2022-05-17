class RecipesController < ApplicationController
  def index
    if current_user
      @recipes = Recipe.where(id: current_user.id)
    else
      flash[:alert] = 'You need to login in order to see your recipes.'
    end
  end

  def show; end

  def new; end

  def create; end

  def public_recipes; end
end
