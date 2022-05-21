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
    food1 = Food.new(name: 'Apple',
                     measurement_unit: 'grams',
                     price: 1.15,
                     user: user)
    food2 = Food.new(name: 'Orange',
                     measurement_unit: 'kg',
                     price: 15.5,
                     user: user)
    food1.save
    food2.save
  end

  # rubocop:disable Metrics/BlockLength
  context 'list view' do
    before :each do
      visit '/users/sign_in'
      within('#new_user') do
        fill_in 'Email', with: 'adam@domain.com'
        fill_in 'Password', with: 'password'
      end
      click_button 'Log in'
    end

    it 'should display foods in list view' do
      visit foods_path

      expect(current_path).to eq foods_path
      expect(page).to have_link('Add Food')
      expect(page).to have_button('Delete')
      expect(page).to have_selector(:css, 'ul.list-group')
      within('ul.list-group') do
        expect(page).to have_css('li', count: 3)
        expect(page.all('li')[1]).to have_text('Apple')
      end
      expect(page).to have_content('Apple')
      expect(page).to have_content('Orange')
    end

    it 'should remove food from list upon delete button click' do
      visit foods_path

      expect(current_path).to eq foods_path
      expect(page).to have_button('Delete')
      within('ul.list-group') do
        within(page.all('li')[1]) do
          click_button('Delete')
        end
        expect(page).to have_css('li', count: 2)
        expect(page.all('li')[1]).not_to have_text('Apple')
      end
      expect(page).to have_content('Orange')
    end
  end
  # rubocop:enable Metrics/BlockLength
end
