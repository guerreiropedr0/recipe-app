require 'rails_helper'

RSpec.describe Recipe, type: :model do
  context 'validation' do
    before :example do
      @recipe = Recipe.create(name: 'French macaroons', preparation_time: '20', cooking_time: '15',
                              description: 'Delicious snack', public: true)
    end

    it 'should be valid with valid attributes' do
      expect(@recipe).to be_valid
    end

    it 'should be invalid without a name' do
      @recipe.name = nil

      expect(@recipe).to_not be_valid
    end

    it 'should be invalid without a preparation time' do
      @recipe.preparation_time = nil

      expect(@recipe).to_not be_valid
    end

    it 'should be invalid without a cooking time' do
      @recipe.cooking_time = nil

      expect(@recipe).to_not be_valid
    end

    it 'should be invalid with a description under 1 character and over 200 characters' do
      @recipe.description = ''

      expect(@recipe).to_not be_valid

      @recipe.description = 'a' * 201

      expect(@recipe).to_not be_valid
    end

    it 'should be invalid with without a public value' do
      @recipe.public = nil

      expect(@recipe).to_not be_valid
    end
  end
end
