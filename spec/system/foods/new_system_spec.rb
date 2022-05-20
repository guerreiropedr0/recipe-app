require 'rails_helper'

RSpec.describe 'Foods', type: :system do
  before :all do
    driven_by(:rack_test)
  end

  it 'add new food should create new food' do
    visit '/users/sign_in'
    within('#new_user') do
      fill_in 'Email', with: 'adam@domain.com'
      fill_in 'Password', with: 'password'
    end
    click_button 'Log in'
    visit foods_path

    click_link('Add Food')
    fill_in 'Name', with: 'Orange'
    fill_in 'Measurement unit', with: 'kg'
    fill_in 'Price', with: 5.5
    find('input[name="commit"]').click

    expect(current_path).to eq foods_path
    expect(page).to have_content('Orange')
  end
end
