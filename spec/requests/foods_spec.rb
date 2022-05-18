require 'rails_helper'

RSpec.describe 'Foods', type: :request do
  Food.delete_all
  User.delete_all
  user = User.new(name: 'Adam',
                  email: 'adam@mail.com',
                  password: 'password',
                  password_confirmation: 'password')
  food = Food.new(name: 'Apple',
                  measurement_unit: 'grams',
                  price: 1.15,
                  user: user)
  before(:all) do
    user.save
    food.save
    user.confirm
    sign_in user
  end

  describe 'GET /foods' do
    it 'returns http success' do
      get '/foods'
      expect(response).to have_http_status(:success)
    end

    it "renders 'index' template" do
      get '/foods'
      expect(response).to render_template('index')
    end

    it 'page contains text' do
      get '/foods'
      expect(response.body).to include('There are no registered foods, yet')
    end
  end

  describe 'GET /foods/{id}' do
    it 'returns http success' do
      get "/foods/#{food.id}"
      expect(response).to have_http_status(:success)
    end
  end

  describe 'GET /new' do
    it 'returns http success' do
      get '/foods/new'
      expect(response).to have_http_status(:success)
    end
  end

  describe 'POST /foods' do
    it 'returns http success' do
      post '/foods', params: { food: { name: food.name, measurement_unit: food.measurement_unit, price: food.price } }
      expect(response).to have_http_status(200)
    end
  end

  describe 'DELETE /foods/{id}' do
    it 'returns http success' do
      delete food_path(food)
      expect(response).to have_http_status(302)
    end
  end
end
