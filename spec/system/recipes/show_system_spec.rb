require 'rails_helper'

RSpec.describe 'Recipes', type: :system do
  let(:user) do
    FactoryBot.create(:user, name: 'Pedro Guerreiro', email: 'pedro@domain.com', password: '123456',
                             password_confirmation: '123456')
  end

  # rubocop:disable Metrics/BlockLength
  context 'show page' do
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

      visit recipe_path(id: @recipe.id)
    end

    it 'should display recipe name' do
      expect(page).to have_content(@recipe.name)
    end

    it 'should display recipe preparation time' do
      expect(page).to have_content("Preparation time: #{@recipe.preparation_time} minutes")
    end

    it 'should display recipe preparation time' do
      expect(page).to have_content("Cooking time: #{@recipe.cooking_time} minutes")
    end

    it 'should display boilerplate text for steps' do
      expect(page).to have_content('Steps go here...')
    end

    it 'should find all clickable links' do
      find_button('Generate shopping list')
      find_link('Add ingredient')
    end

    it 'should click add ingredient link and redirect to new recipe_food form' do
      click_link('Add ingredient')

      expect(page).to have_current_path(new_recipe_recipe_food_path(recipe_id: @recipe.id))
    end
  end
  # rubocop:enable Metrics/BlockLength
end
