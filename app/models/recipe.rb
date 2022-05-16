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
class Recipe < ApplicationRecord
end
