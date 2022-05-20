require 'rails_helper'

RSpec.describe 'Inventories', type: :system do
  let(:user) do
    FactoryBot.create(:user, name: 'Edward', email: 'oluyaratosin123@gmail.com', password: 'root17',
                             password_confirmation: 'root17')
  end

  context 'show page' do
    before(:each) do
      driven_by(:rack_test)

      @inventory = Inventory.create(name: 'Yara', description: 'Second inventory', user_id: user.id)

      user.confirm

      visit new_user_session_path

      fill_in('Email', with: 'oluyaratosin123@gmail.com')
      fill_in('Password', with: 'root17')
      click_button('Log in')

      visit inventory_path(id: @inventory.id)
    end

    it 'should display inventory name' do
      expect(page).to have_content(@inventory.name)
    end

    it 'should display inventory description' do
      expect(page).to have_content('Second Inventory')
    end

    it 'should find all clickable links' do
      find_link('Add Inventory')
    end
  end
end
