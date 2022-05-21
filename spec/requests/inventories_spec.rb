require 'rails_helper'

RSpec.describe 'Inventories', type: :request do
  let(:user) do
    FactoryBot.create(:user, name: 'Pedro Guerreiro', email: 'pedro@domain.com', password: '123456',
                             password_confirmation: '123456')
  end

  let(:inventory) do
    FactoryBot.create(:inventory, name: 'Edward', user_id: user.id, description: 'Test')
  end

  describe 'GET /index' do
    before :example do
      user.confirm
      sign_in user
      get inventories_path
    end

    it 'should render the index view template' do
      expect(response).to render_template(:index)
    end

    it 'should have the exact page content' do
      expect(response.body).to include('Your Inventories')
    end
  end

  describe 'GET /inventories/:id' do
    before :example do
      user.confirm
      sign_in user
      get inventory_path(id: inventory.id)
    end

    it 'should render the show view template' do
      expect(response).to render_template(:show)
    end

    it 'should have the exact page content' do
      expect(response.body).to include(inventory.name)
    end
  end
end
