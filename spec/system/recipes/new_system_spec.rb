require 'rails_helper'

RSpec.describe 'Recipes', type: :system do
  let(:user) do
    FactoryBot.create(:user, name: 'Pedro Guerreiro', email: 'pedro@domain.com', password: '123456',
                             password_confirmation: '123456')
  end

  context 'index page' do
    before(:each) do
      driven_by(:rack_test)

      user.confirm

      visit new_user_session_path

      fill_in('Email', with: 'pedro@domain.com')
      fill_in('Password', with: '123456')
      click_button('Log in')

      visit new_recipe_path
    end

    it 'should display welcoming message' do
      expect(page).to have_content('Add new recipe:')
    end

    it 'should display all fields' do
      find_field('Name')
      find_field('Description')
      find_field('Cooking time')
      find_field('Preparation time')
      find_field('Public')
      find_button('Create')
    end

    it 'should not create a recipe if one of the fields is empty' do
      fill_in('Name', with: 'French macaroons')
      fill_in('Description', with: 'Yummy')

      click_button('Create')

      expect(page).to_not have_content('Successfully created recipe.')
    end

    it 'should create a recipe if every field is filled' do
      fill_in('Name', with: 'French macaroons')
      fill_in('Description', with: 'Yummy')
      fill_in('Cooking time', with: '20')
      fill_in('Preparation time', with: '20')
      find_field('Public').set(true)

      click_button('Create')

      expect(page).to have_content('Successfully created recipe.')
    end
  end
end
