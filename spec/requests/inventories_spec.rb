require 'rails_helper'

RSpec.describe 'Inventories', type: :request do
  describe 'GET /index' do
    before :example do
      get '/users/sign_in'
      get inventories_path
    end

    it 'should render the index view template' do
      expect(response).to render_template(:index)
    end

    it 'should have the exact page content' do
      expect(response.body).to include('This page would be for all the listed inventories by a given user')
    end
  end

  describe 'GET /inventories/:id' do
    before :example do
      get inventories_path(id: 1)
    end

    it 'should render the show view template' do
      expect(response).to render_template(:show)
    end

    it 'should have the exact page content' do
      expect(response.body).to include('Inventories by')
    end
  end
end
