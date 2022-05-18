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
require 'rails_helper'

RSpec.describe InventoryFood, type: :model do
  let(:user) do
    FactoryBot.create(:user, name: 'Edward Yara', email: 'oluyaratosin123@gmail.com', password: 'root17', password_confirm: 'root17')
  end

  let(:inventory) do
    FactoryBot.create(:inventory, name: 'Jonathan King', user_id: user.id)
  end

  let(:food) do
    FactoryBot.create(:food, name: 'Grapes', measurement_unit: 'g', price: 1.15)
  end

  let(:inventory_food) do
    FactoryBot.create(:inventory_food, quantity: 5, food_id: food.id, inventory_id: inventory.id)
  end

  context 'Validate' do
    it 'should have a valid attribute' do
      expect(inventory_food).to be_valid
    end

    it 'should be invalid if no quantity has been added' do
      inventory_food.quantity = ''

      expect(inventory_food).to_not be_valid
    end

    it 'should be invalid if the quantity value is 0' do
      inventory_food.quantity = 0

      expect(inventory_food).to_not be_valid
    end

    it 'should be invalid without a food id' do
      inventory_food.food_id = ''

      expect(inventory_food).to_not be_valid
    end

    it 'should be invalid without the inventory id' do
      inventory_food.inventory_id = ''

      expect(inventory_food).to_not be_valid
    end
  end
end
