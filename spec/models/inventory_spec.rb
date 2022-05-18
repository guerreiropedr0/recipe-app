# == Schema Information
#
# Table name: inventories
#
#  id         :bigint           not null, primary key
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
require 'rails_helper'

RSpec.describe Inventory, type: :model do
  describe 'Inventory model' do
    let(:user) { FactoryBot.create(:user, name: 'John') }
    let(:inventory) { FactoryBot.create(:inventory, name: 'Edward', user_id: user.id) }
  end

  before { inventory.save }

  it 'should check for valid attributes' do
    expect(inventory).to be_valid
  end

  it 'should be invalid without name attribute' do
    inventory.name = ''

    expect(inventory).to_not be_valid
  end
end
