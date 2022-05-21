require 'rails_helper'

RSpec.describe 'Recipes', type: :system do
  # rubocop:disable Metrics/BlockLength
  context 'sign up page' do
    before(:each) do
      driven_by(:rack_test)

      visit new_user_registration_path
    end

    it 'should display welcoming message' do
      expect(page).to have_content('Sign up')
    end

    it 'should display all fields' do
      find_field('Email')
      find_field('Name')
      find_field('Password')
      find_field('Password confirmation')
      find_button('Sign up')
    end

    it 'should display errors if all fields are blank' do
      click_button('Sign up')

      expect(page).to have_content(
        "3 errors prohibited this user from being saved:
Email can't be blank
Password can't be blank
Name can't be blank"
      )
    end

    it 'should display error if password is less than 6 characters' do
      fill_in('Email', with: 'pedro@domain.com')
      fill_in('Name', with: 'Pedro Guerreiro')
      fill_in('Password', with: '12345')
      fill_in('Password confirmation', with: '12345')

      click_button('Sign up')

      expect(page).to have_content(
        'Password is too short (minimum is 6 characters)'
      )
    end

    it 'should display error if password doesn\'t match password confirmation' do
      fill_in('Email', with: 'pedro@domain.com')
      fill_in('Name', with: 'Pedro Guerreiro')
      fill_in('Password', with: '123456')
      fill_in('Password confirmation', with: 'not_the_same')

      click_button('Sign up')

      expect(page).to have_content(
        "Password confirmation doesn't match Password"
      )
    end

    it 'should create user' do
      fill_in('Email', with: 'pedro@domain.com')
      fill_in('Name', with: 'Pedro Guerreiro')
      fill_in('Password', with: '123456')
      fill_in('Password confirmation', with: '123456')

      click_button('Sign up')

      expect(page).to have_current_path(root_path)
    end

    it 'should display all links' do
      find_link('Log in')
      find_link('Didn\'t receive confirmation instructions?')
    end

    it 'should click log in link and redirect to log in form' do
      click_link('Log in')

      expect(page).to have_current_path(new_user_session_path)
    end

    it 'should click confirmation link and redirect to confirmation form' do
      click_link('Didn\'t receive confirmation instructions?')

      expect(page).to have_current_path(new_user_confirmation_path)
    end
  end
  # rubocop:enable Metrics/BlockLength
end
