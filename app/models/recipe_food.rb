# == Schema Information
#
# Table name: recipe_foods
#
#  id         :bigint           not null, primary key
#  quantity   :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  food_id    :bigint           not null
#  recipe_id  :bigint           not null
#
# Indexes
#
#  index_recipe_foods_on_food_id    (food_id)
#  index_recipe_foods_on_recipe_id  (recipe_id)
#
# Foreign Keys
#
#  fk_rails_...  (food_id => foods.id)
#  fk_rails_...  (recipe_id => recipes.id)
#
class RecipeFood < ApplicationRecord
  belongs_to :recipe
  belongs_to :food
end
