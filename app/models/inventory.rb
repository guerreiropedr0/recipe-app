class Inventory < ApplicationRecord
  validates :name, presence: true

  belongs_to :user, class_name: 'user', foreign_key: 'user_id'
  has_many :recipes

  def three_most_recent_inventories
    inventories.order(created_at: :desc).limit(3)
  end
end
