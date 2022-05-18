# == Schema Information
#
# Table name: inventory_foods
#
#  id           :bigint           not null, primary key
#  quantity     :integer
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  food_id      :bigint           not null
#  inventory_id :bigint           not null
#
# Indexes
#
#  index_inventory_foods_on_food_id       (food_id)
#  index_inventory_foods_on_inventory_id  (inventory_id)
#
# Foreign Keys
#
#  fk_rails_...  (food_id => foods.id)
#  fk_rails_...  (inventory_id => inventories.id)
#
class InventoryFood < ApplicationRecord
  belongs_to :inventory
  belongs_to :food

  validates :quantity, numericality: { greater_than_or_equal_to: 1 }
  validates :inventory_id, presence: true
  validates :food_id, presence: true
end
