# == Schema Information
#
# Table name: recipe_foods
#
#  id         :bigint           not null, primary key
#  quantity   :integer          default(0)
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

  validates :quantity, numericality: { greater_than_or_equal_to: 1 }
  validates :food_id, presence: true
  validates :recipe_id, presence: true

  def self.add_food(recipe_id, food_id, quantity)
    RecipeFood.create(recipe_id: recipe_id, food_id: food_id, quantity: quantity)
  end
end
