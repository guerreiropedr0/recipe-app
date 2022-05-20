require 'rails_helper'

RSpec.describe 'Recipes', type: :system do
  let(:user) do
    FactoryBot.create(:user, name: 'Pedro Guerreiro', email: 'pedro@domain.com', password: '123456',
                             password_confirmation: '123456')
  end

  context 'index page' do
    before(:each) do
      driven_by(:rack_test)

      @recipe = Recipe.create(name: 'French macaroons', preparation_time: '20', cooking_time: '15',
                                   description: 'Delicious snack', public: true,
                                   user_id: user.id)

      user.confirm

      visit new_user_session_path

      fill_in('Email', with: 'pedro@domain.com')
      fill_in('Password', with: '123456')
      click_button('Log in')

      visit recipes_path
    end

    it 'should display welcoming message' do
      expect(page).to have_content('Your Recipes')
    end

    it 'should display recipe name' do
      expect(page).to have_content(@recipe.name)
    end

    it 'should display recipe description' do
      expect(page).to have_content(@recipe.description)
    end

    it 'should find all clickable links' do
      find_link('REMOVE')
      find_link(@recipe.name)
      find_link('New Recipe')
    end

    it 'should click remove link and remove recipe' do
      click_link('REMOVE')

      expect(page).to_not have_content(@recipe.name)
    end

    it 'should click new recipe link and redirect to new recipe form' do
      click_link('New Recipe')

      expect(page).to have_current_path(new_recipe_path)
    end

    it 'should click recipe link and redirect to recipe details' do
      click_link(@recipe.name)

      expect(page).to have_current_path(recipe_path(id: @recipe.id))
    end
  end
end
