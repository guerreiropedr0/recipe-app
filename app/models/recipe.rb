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
#  user_id          :bigint           not null
#
# Indexes
#
#  index_recipes_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#
class Recipe < ApplicationRecord
  belongs_to :user
  has_many :recipe_foods

  validates :name, presence: true
  validates :preparation_time, numericality: { in: 1..1440 }
  validates :cooking_time, numericality: { in: 1..1440 }
  validates :description, length: { in: 1..200 }
  validates :public, exclusion: [nil]
end
