require 'rails_helper'

RSpec.describe 'Inventories', type: :system do
  let(:user) do
    FactoryBot.create(:user, name: 'Pedro Guerreiro', email: 'pedro@domain.com', password: '123456',
                             password_confirmation: '123456')
  end

  # rubocop:disable Metrics/BlockLength
  context 'show page' do
    before(:each) do
      driven_by(:rack_test)

      @inventory = Inventory.create(name: 'Inventory 1', description: 'Test', user_id: user.id)
      @food = Food.create(name: 'Apple', measurement_unit: 'units', price: 5, user_id: user.id)
      @inventory_food = InventoryFood.create(quantity: 5, inventory_id: @inventory.id, food_id: @food.id)

      user.confirm

      visit new_user_session_path

      fill_in('Email', with: 'pedro@domain.com')
      fill_in('Password', with: '123456')
      click_button('Log in')

      visit inventory_path(id: @inventory.id)
    end

    it 'should display inventory name' do
      expect(page).to have_content(@inventory.name)
    end

    it 'should find all clickable links' do
      find_link('Add food')
      find_link('Remove')
    end

    it 'should display food name' do
      expect(page).to have_content(@food.name)
    end

    it 'should click remove link and remove inventory food' do
      click_link('Remove')

      expect(page).to_not have_content(@food.name)
      expect(page).to have_content('Successfully deleted food.')
    end

    it 'should click add food link and redirect to add new inventory food form' do
      click_link('Add food')

      expect(page).to have_current_path(new_inventory_inventory_food_path(inventory_id: @inventory.id))
    end
  end
  # rubocop:enable Metrics/BlockLength
end
