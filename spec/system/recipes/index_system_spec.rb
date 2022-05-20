require 'rails_helper'

RSpec.describe 'Recipes', type: :system do
  let(:user) do
    FactoryBot.create(:user, name: 'Pedro Guerreiro', email: 'pedro@domain.com', password: '123456',
                             password_confirmation: '123456')
  end

  let(:recipe) do
    FactoryBot.create(:recipe, name: 'French macaroons', preparation_time: '20', cooking_time: '15',
                               description: 'Delicious snack', public: true,
                               user_id: user.id)
  end

  context 'index page' do
    before(:each) do
      driven_by(:rack_test)

      user.confirm

      visit new_user_session_path

      fill_in('Email', with: 'pedro@domain.com')
      fill_in('Password', with: '123456')
      click_button('Log in')

      visit recipes_path
    end

    it 'should show welcoming message' do
      expect(page).to have_content('Your Recipes')
    end
  end
end
