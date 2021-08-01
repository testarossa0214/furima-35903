class Item < ApplicationRecord
  # has_one :order
  belongs_to :user
  # has_many :comments
  has_one_attached :image

  extend ActiveHash::Associations::ActiveRecordExtensions
  has_many :categories
  has_many :statuses
  has_many :postages
  has_many :prefectures
  has_many :shipping_dates

  validates :product, :product_description, :price, presence: true

  validates :category, :status, :postage, :prefecture, :shipping_date, numericality: { other_than: 1 , message: "can't be blank" }

end
