require 'rails_helper'

RSpec.describe 'Inventories', type: :system do
  context 'inventory index page' do
    before(:each) do
      driven_by(:rake_test)

      @shopping_list = ShoppingList.create(food: 'Apple', quantity: 5, price: 1.25, user_id: user.id)

      user.confirm

      visit new_user_session_path

      visit inventory_shopping_list_path
    end

    it 'should display welcoming message' do
      expect(page).to have_content('Shopping Lists')
    end

    it 'should display shopping list food' do
      expect(page).to have_content(@shopping_list.food)
    end

    it 'should display shopping list food quantity' do
      expect(page).to have_content(@shopping_list.quantity)
    end

    it 'should display shopping list food price' do
      expect(page).to have_content(@shopping_list.price)
    end
  end
end
