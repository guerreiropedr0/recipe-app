# == Schema Information
#
# Table name: foods
#
#  id               :bigint           not null, primary key
#  measurement_unit :string           not null
#  name             :string           not null
#  price            :decimal(, )      default(0.0)
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  user_id          :bigint           not null
#
# Indexes
#
#  index_foods_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#
require 'rails_helper'

RSpec.describe Food, type: :model do
  let(:user) do
    FactoryBot.create(:user,
                      name: 'Adam',
                      email: 'adam@mail.com',
                      password: 'password',
                      password_confirmation: 'password')
  end
  let(:food) do
    FactoryBot.create(:food,
                      name: 'Apple',
                      measurement_unit: 'grams',
                      price: 1.15,
                      user: user)
  end

  describe 'validate data: ' do
    it 'should create valid food record with valid attributes' do
      expect(food).to be_valid
    end

    it 'name should be present' do
      food.name = nil
      expect(food).to_not be_valid

      food.name = ''
      expect(food).to_not be_valid
    end

    it 'user should be present' do
      food.user = nil
      expect(food).to_not be_valid
    end

    it 'measurement-unit should be present' do
      food.measurement_unit = nil
      expect(food).to_not be_valid

      food.measurement_unit = ''
      expect(food).to_not be_valid
    end

    it 'price should be number' do
      food.price = 'One hundered twenty five and thirty five cents'
      expect(food).to_not be_valid
    end

    it 'price should be greater or equal to 0.0' do
      food.price = -100.53
      expect(food).to_not be_valid
    end
  end
end
