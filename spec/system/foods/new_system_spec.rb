require 'rails_helper'

RSpec.describe 'Foods', type: :system do
  before :all do
    driven_by(:rack_test)
  end

  context 'add new food page' do
    before :each do
      visit '/users/sign_in'
      within('#new_user') do
        fill_in 'Email', with: 'adam@domain.com'
        fill_in 'Password', with: 'password'
      end
      click_button 'Log in'
    end

    it "should render add new food view" do
      visit foods_path
      click_link('Add Food')

      expect(page).to have_field("Name")
      expect(page).to have_field("Measurement unit")
      expect(page).to have_field("Price")
      expect(page).to have_selector('input[name="commit"]')
    end

    it 'should create new food with valid inputs' do
      visit foods_path
      click_link('Add Food')
      fill_in 'Name', with: 'Orange'
      fill_in 'Measurement unit', with: 'kg'
      fill_in 'Price', with: 5.5
      find('input[name="commit"]').click

      expect(current_path).to eq foods_path
      expect(page).to have_content('Orange')
    end

    it 'should display error messages on empty name' do
      visit foods_path
      click_link('Add Food')
      fill_in 'Name', with: ''
      fill_in 'Measurement unit', with: 'kg'
      fill_in 'Price', with: 5.5
      find('input[name="commit"]').click

      expect(page).to have_content('Name can\'t be blank')
    end

    it 'should display error messages on empty measurement unit' do
      visit foods_path
      click_link('Add Food')
      fill_in 'Name', with: 'Orange'
      fill_in 'Measurement unit', with: ''
      fill_in 'Price', with: 5.5
      find('input[name="commit"]').click

      expect(page).to have_content('Measurement unit can\'t be blank')
    end

    it 'should display error messages on price less than or equal to zero' do
      visit foods_path
      click_link('Add Food')
      fill_in 'Name', with: 'Orange'
      fill_in 'Measurement unit', with: ''
      fill_in 'Price', with: 0.0
      find('input[name="commit"]').click

      expect(page).to have_content('Price must be greater than 0.0')
    end
  end
end
