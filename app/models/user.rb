class User < ApplicationRecord
  validates :name, length: { maximum: 100 }, presence: true
end
