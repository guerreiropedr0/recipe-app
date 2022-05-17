require 'rails_helper'

RSpec.describe 'Recipes', type: :request do
  describe 'GET /index' do
    before :example do
      get recipes_path
    end

    it 'should render index view' do
      expect(response).to render_template(:index)
    end

    it 'should have boilerplate text content' do
      expect(response.body).to include('This will be all the recipes for a given user')
    end
  end

  describe 'GET /recipes/:id' do
    before :example do
      get recipe_path(id: 1)
    end

    it 'should render show view' do
      expect(response).to render_template(:show)
    end

    it 'should have boilerplate text content' do
      expect(response.body).to include('This will be specific recipe')
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
      expect(response.body).to include('This will be all recipes that are public')
    end
  end
end
