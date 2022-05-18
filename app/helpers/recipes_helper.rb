module RecipesHelper
  def total_food_items(recipe_id)
    @sub_total = [0, 0]
    if (@recipe_foods = RecipeFood.where(recipe_id: recipe_id))
      @recipe_foods.each do |recipe_food|
        @sub_total[0] += recipe_food.quantity
        @food = Food.find_by(id: recipe_food.food_id)
        @sub_total[1] += @food.price * recipe_food.quantity
      end
    end
    @sub_total
  end
end
