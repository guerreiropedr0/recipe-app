# == Schema Information
# Table name: inventories
#
#  id         :bigint           not null, primary key
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Inventory < ApplicationRecord
  validates :name, presence: true

  belongs_to :user, class_name: 'user', foreign_key: 'user_id'
end
