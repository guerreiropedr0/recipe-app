# == Schema Information
#
# Table name: users
#
#  id         :bigint           not null, primary key
#  name       :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) { FactoryBot.create(:user, name: 'Tekle') }

  describe 'validate data: ' do
    it 'name should be present' do
      user.name = ''
      expect(user).to_not be_valid
    end

    it 'name should be present' do
      user.name = 'John'
      expect(user).to be_valid
    end

    it 'name length should not be greate than 100 characters' do
      user.name = puts 'John' * 26
      expect(user).to_not be_valid
    end
  end
end
