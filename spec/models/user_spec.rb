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
      user.name = 'JohnLorem ipsum dolor sit amet, consectetuer adipiscing \
        elit. Aenean commodo ligula eget dolor. Aenean massa. Cum sociis \
        natoque penatibus et magnis dis parturient montes, nascetur ridiculus \
        mus. Donec quam felis, ultricies nec, pellentesque eu, pretium quis, \
        sem. Nulla consequat massa quis enim. Donec pede justo, fringilla vel,\
        aliquet nec, vulputate eget, arcu. In enim justo, rhoncus ut, imperdiet \
        a, venenatis vitae, justo. Nullam dictum felis eu pede mollis pretium. \
        Integer tincidunt. Cras dapibus. Vivamus elementum semper nisi. Aenean \
        vulputate eleifend tellus. Aenean leo ligula, porttitor eu, consequat \
        vitae, eleifend ac, enim. Aliquam lorem ante, dapibus in, viverra quis, \
        feugiat a, tellus.'
      expect(user).to_not be_valid
    end
  end
end
