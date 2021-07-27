class Item < ApplicationRecord
  # has_one :order
  belongs_to :user
  # has_many :comments
end
