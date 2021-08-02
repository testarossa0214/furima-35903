class Item < ApplicationRecord
  # has_one :order
  belongs_to :user
  # has_many :comments
  has_one_attached :image

  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :category
  belongs_to :status
  belongs_to :postage
  belongs_to :prefecture
  belongs_to :shipping_date

  validates :product, :product_description, presence: true
  validates :price, presence: true, format: { with: /\A[0-9]+\z/ }

  validates :category_id, :status_id, :postage_id, :prefecture_id, :shipping_date_id, numericality: { other_than: 1 , message: "can't be blank" }

end
