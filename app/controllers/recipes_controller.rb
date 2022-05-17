class RecipesController < ApplicationController
  def index
    @recipes = Recipe.all
  end

  def show; end

  def public_recipes; end
end
