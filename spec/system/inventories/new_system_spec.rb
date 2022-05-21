require 'rails_helper'

RSpec.describe 'Inventories', type: :system do
  let(:user) do
    FactoryBot.create(:user, name: 'Pedro Guerreiro', email: 'pedro@domain.com', password: '123456',
                             password_confirmation: '123456')
  end

  # rubocop:disable Metrics/BlockLength
  context 'new page' do
    before(:each) do
      driven_by(:rack_test)

      user.confirm

      visit new_user_session_path

      fill_in('Email', with: 'pedro@domain.com')
      fill_in('Password', with: '123456')
      click_button('Log in')

      visit new_inventory_path
    end

    it 'should display welcoming message' do
      expect(page).to have_content('Add new inventory')
    end

    it 'should display all fields' do
      find_field('Name')
      find_field('Description')
      find_button('Create')
    end

    it 'should not create an inventory if one of the fields is empty' do
      fill_in('Name', with: 'Inventory 1')

      click_button('Create')

      expect(page).to_not have_content('Successfully created Inventory.')
    end

    it 'should create an inventory if all fields are filled' do
      fill_in('Name', with: 'Inventory 1')
      fill_in('Description', with: 'Test')

      click_button('Create')

      expect(page).to have_content('Successfully created Inventory.')
    end
  end
  # rubocop:enable Metrics/BlockLength
end
