require 'rails_helper'

RSpec.describe 'Foods', type: :system do
  before :all do
    driven_by(:rack_test)

    Food.delete_all
    User.delete_all
    visit '/users/sign_up'
    within('#new_user') do
      fill_in 'Email', with: 'adam@domain.com'
      fill_in 'Name', with: 'Adam'
      fill_in 'Password', with: 'password'
      fill_in 'Password confirmation', with: 'password'
      click_button 'Sign up'
    end
    user = User.find_by(email: 'adam@domain.com')
    user.confirm
    food = Food.new(name: 'Apple',
                    measurement_unit: 'grams',
                    price: 1.15,
                    user: user)
    food.save
  end

  it 'should display food in list view' do
    visit '/users/sign_in'
    within('#new_user') do
      fill_in 'Email', with: 'adam@domain.com'
      fill_in 'Password', with: 'password'
    end
    click_button 'Log in'
    visit foods_path

    expect(current_path).to eq foods_path
    expect(page).to have_content('Apple')
  end
end
