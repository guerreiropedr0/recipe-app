require 'rails_helper'

RSpec.describe 'Recipes', type: :request do
  let(:user) do
    FactoryBot.create(:user, name: 'Pedro Guerreiro', email: 'pedro@domain.com', password: '123456',
                             password_confirmation: '123456')
  end

  describe 'GET /index' do
    before :example do
      user.confirm
      sign_in user
      get recipes_path
    end

    it 'should render index view' do
      expect(response).to render_template(:index)
    end

    it 'should have boilerplate text content' do
      expect(response.body).to include('Your Recipes')
    end
  end

  describe 'GET /recipes/:id' do
    let(:user) do
      FactoryBot.create(:user, name: 'Pedro Guerreiro', email: 'pedro@domain.com', password: '123456',
                               password_confirmation: '123456')
    end

    let(:recipe) do
      FactoryBot.create(:recipe, name: 'French macaroons', preparation_time: '20', cooking_time: '15',
                                 description: 'Delicious snack', public: true,
                                 user_id: user.id)
    end

    before :example do
      get recipe_path(id: recipe.id)
    end

    it 'should render show view' do
      expect(response).to render_template(:show)
    end

    it 'should have boilerplate text content' do
      expect(response.body).to include(recipe.name)
    end
  end

  describe 'GET /public_recipes' do
    before :example do
      get public_recipes_path
    end

    it 'should render show view' do
      expect(response).to render_template(:public_recipes)
    end

    it 'should have boilerplate text content' do
      expect(response.body).to include('Public Recipes')
    end
  end
end
