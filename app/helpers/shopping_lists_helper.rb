module ShoppingListsHelper
  def shoping_list
    @shoppinglist = []
    @recipe_foods = RecipeFood.where(recipe_id: params[:recipe_id])
    @inventory_foods = InventoryFood.where(inventory_id: params[:inventory][:inventory_id])

    @recipe_foods.each do |recipe_food|
      is_food_in_inventory = false
      target_food = food(recipe_food.food_id)
      @inventory_foods.each do |inventory_food|
        quantity_to_shop = recipe_food.quantity - inventory_food.quantity
        if inventory_food.food_id == recipe_food.food_id && quantity_to_shop > 0
          is_food_in_inventory = true
          @shoppinglist.push({ food_id: recipe_food.food_id,
                              food_name: target_food.name,
                              food_uom: target_food.measurement_unit,
                              quantity: quantity_to_shop,
                              price: target_food.price })
        end
      end
      unless is_food_in_inventory
        @shoppinglist.push({ food_id: recipe_food.food_id,
                            food_name: target_food.name,
                            food_uom: target_food.measurement_unit,
                            quantity: recipe_food.quantity,
                            price: target_food.price })
      end
    end

    @shoppinglist
  end

  def total_value_of_food_needed(shoping_list)
    total_value = 0
    shoping_list.each do |item|
      total_value += item[:quantity] * item[:price]
    end
    
    total_value
  end

  private

  def food(id)
    Food.find(id)
  end
end