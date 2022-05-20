require 'rails_helper'

RSpec.describe 'LoginPages', type: :system do
  before(:all) do
    # Comment the line below this to see selinium open chrome browser
    driven_by(:rack_test)
    user = User.find_by(email: 'adam@domain.com')
    user.confirm
  end

  it 'renders sign in page' do
    visit '/users/sign_in'

    expect(page).to have_field('user_email')
    expect(page).to have_field('user_password')
    expect(page).to have_button('Log in')
  end

  it 'Error: Invalid Email or password with empty email and password' do
    visit '/users/sign_in'
    within('#new_user') do
      fill_in 'Email', with: ''
      fill_in 'Password', with: ''
    end
    click_button 'Log in'
    expect(page).to have_content 'Invalid Email or password.'
  end

  it 'Error: Invalid Email or password with wrong password' do
    visit '/users/sign_in'
    within('#new_user') do
      fill_in 'Email', with: 'adam@domain.com'
      fill_in 'Password', with: '123456'
    end
    click_button 'Log in'
    expect(page).to have_content 'Invalid Email or password.'
  end

  it 'Error: Invalid Email or password with wrong email' do
    visit '/users/sign_in'
    within('#new_user') do
      fill_in 'Email', with: 'eve@domain.com'
      fill_in 'Password', with: 'password'
    end
    click_button 'Log in'
    expect(page).to have_content 'Invalid Email or password.'
  end

  it 'signs me in with valid email and password' do
    visit '/users/sign_in'
    within('#new_user') do
      fill_in 'Email', with: 'adam@domain.com'
      fill_in 'Password', with: 'password'
    end
    click_button 'Log in'
    expect(page).to have_content 'Sign out'
  end
end
