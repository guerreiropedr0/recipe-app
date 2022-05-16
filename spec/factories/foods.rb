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
FactoryBot.define do
  factory :food do
    name { "MyString" }
    measurement_unit { "MyString" }
    price { "9.99" }
    user { nil }
  end
end
