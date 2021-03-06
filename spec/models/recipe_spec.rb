# == Schema Information
#
# Table name: recipes
#
#  id               :bigint           not null, primary key
#  cooking_time     :integer
#  description      :text
#  name             :string
#  preparation_time :integer
#  public           :boolean
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  user_id          :bigint           not null
#
# Indexes
#
#  index_recipes_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#
require 'rails_helper'

RSpec.describe Recipe, type: :model do
  let(:user) do
    FactoryBot.create(:user, name: 'Pedro Guerreiro', email: 'pedro@domain.com', password: '123456',
                             password_confirmation: '123456')
  end

  let(:recipe) do
    FactoryBot.create(:recipe, name: 'French macaroons', preparation_time: '20', cooking_time: '15',
                               description: 'Delicious snack', public: true,
                               user_id: user.id)
  end

  context 'validation' do
    it 'should be valid with valid attributes' do
      expect(recipe).to be_valid
    end

    it 'should be invalid without a name' do
      recipe.name = nil

      expect(recipe).to_not be_valid
    end

    it 'should be invalid with a description under 1 character and over 200 characters' do
      recipe.description = ''

      expect(recipe).to_not be_valid

      recipe.description = 'a' * 201

      expect(recipe).to_not be_valid
    end

    it 'should be invalid with without a public value' do
      recipe.public = nil

      expect(recipe).to_not be_valid
    end
  end

  context 'preparation_time and cooking_time columns' do
    it 'should be invalid without a preparation time' do
      recipe.preparation_time = nil

      expect(recipe).to_not be_valid
    end

    it 'should be invalid with a preparation time under 1' do
      recipe.preparation_time = 0

      expect(recipe).to_not be_valid
    end

    it 'should be invalid with a preparation time over 2880' do
      recipe.preparation_time = 1441

      expect(recipe).to_not be_valid
    end

    it 'should be invalid without a cooking time' do
      recipe.cooking_time = nil

      expect(recipe).to_not be_valid
    end

    it 'should be invalid with a cooking time under 1' do
      recipe.cooking_time = 0

      expect(recipe).to_not be_valid
    end

    it 'should be invalid with a cooking time over 2880' do
      recipe.cooking_time = 1441

      expect(recipe).to_not be_valid
    end
  end
end
