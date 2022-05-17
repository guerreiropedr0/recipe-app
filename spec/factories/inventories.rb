# == Schema Information
#
# Table name: inventories
#
#  id         :bigint           not null, primary key
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
FactoryBot.define do
  factory :inventory do
    name { 'MyString' }
  end
end
