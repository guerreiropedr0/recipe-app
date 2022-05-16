# == Schema Information
#
# Table name: foods
#
#  id               :bigint           not null, primary key
#  measurement_unit :string           not null
#  name             :string           not null
#  price            :decimal(, )      default(0.0)
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  user_id          :bigint           not null
#
# Indexes
#
#  index_foods_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#
require 'rails_helper'

RSpec.describe Food, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
