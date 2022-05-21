require 'rails_helper'

RSpec.describe 'Foods', type: :request do
  Food.delete_all
  User.delete_all
  let(:user) do
    FactoryBot.create(:user, name: 'Adam', email: 'adam@mail.com', password: 'password',
                             password_confirmation: 'password')
  end

  let(:food) do
    FactoryBot.create(:food,
                      name: 'Apple',
                      measurement_unit: 'grams',
                      price: 1.15,
                      user: user)
  end

  describe 'GET /foods' do
    before :example do
      user.save
      food.save
      user.confirm
      sign_in user
      get foods_path
    end

    it 'returns http success' do
      expect(response).to have_http_status(:success)
    end

    it "renders 'index' template" do
      expect(response).to render_template('index')
    end

    it 'page contains text' do
      expect(response.body).to include(food.name)
    end
  end

  describe 'GET /foods/{id}' do
    before :example do
      user.save
      food.save
      user.confirm
      sign_in user
      get food_path(id: food.id)
    end
    it 'returns http success' do
      expect(response).to have_http_status(:success)
    end
  end

  describe 'GET /new' do
    before :example do
      user.save
      food.save
      user.confirm
      sign_in user
      get new_food_path
    end

    it 'returns http success' do
      expect(response).to have_http_status(:success)
    end
  end

  describe 'DELETE /foods/{id}' do
    it 'returns http success' do
      delete food_path(food)
      expect(response).to have_http_status(302)
    end
  end
end
