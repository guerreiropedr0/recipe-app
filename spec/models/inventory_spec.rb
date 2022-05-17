require 'rails_helper'

RSpec.describe Inventory, type: :model do
  describe 'Inventory model' do
    let(:inventory) { FactoryBot.create(:inventory, name: 'Edward', user_id: 1) }
  end

  before { inventory_queries.save }

  it 'should check for valid attributes' do
    expect(inventory_queries).to be_valid
  end

  it 'should be invalid without name attribute' do
    inventory_queries.name = ''

    expect(inventory_queries).to_not be_valid
  end
end
