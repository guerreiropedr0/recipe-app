# == Schema Information
#
# Table name: recipes
#
#  id               :bigint           not null, primary key
#  cooking_time     :integer
#  description      :text
#  name             :string
#  preparation_time :integer
#  public           :boolean
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#
FactoryBot.define do
  factory :recipe do
    name { 'MyString' }
    preparation_time { 1 }
    cooking_time { 1 }
    description { 'MyText' }
    public { false }
  end
end
