require 'rails_helper'

RSpec.describe 'Inventories', type: :system do
  let(:user) do
    FactoryBot.create(:user, name: 'Pedro Guerreiro', email: 'pedro@domain.com', password: '123456',
                             password_confirmation: '123456')
  end

  # rubocop:disable Metrics/BlockLength
  context 'index page' do
    before(:each) do
      driven_by(:rack_test)

      @inventory = Inventory.create(name: 'Inventory 1', description: 'Test', user_id: user.id)

      user.confirm

      visit new_user_session_path

      fill_in('Email', with: 'pedro@domain.com')
      fill_in('Password', with: '123456')
      click_button('Log in')

      visit inventories_path
    end

    it 'should display welcoming message' do
      expect(page).to have_content('Your Inventories')
    end

    it 'should display inventory name' do
      expect(page).to have_content(@inventory.name)
    end

    it 'should display inventory description' do
      expect(page).to have_content(@inventory.description)
    end

    it 'should find all clickable links' do
      find_link('REMOVE')
      find_link(@inventory.name)
      find_link('New Inventory')
    end

    it 'should click remove link and remove inventory' do
      click_link('REMOVE')

      expect(page).to_not have_content(@inventory.name)
    end

    it 'should click new inventory link and redirect to new inventory form' do
      click_link('New Inventory')

      expect(page).to have_current_path(new_inventory_path)
    end

    it 'should click inventory link and redirect to inventory details' do
      click_link(@inventory.name)

      expect(page).to have_current_path(inventory_path(id: @inventory.id))
    end
  end
  # rubocop:enable Metrics/BlockLength
end
