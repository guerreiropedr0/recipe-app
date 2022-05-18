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
FactoryBot.define do
  factory :inventory_food do
    quantity { 1 }
    inventory { nil }
    food { nil }
  end
end
