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
  validates :name, presence: true
  validates :preparation_time, numericality: { in: 1..1440 }
  validates :cooking_time, numericality: { in: 1..1440 }
  validates :description, length: { in: 1..200 }
  validates :public, presence: true
end
