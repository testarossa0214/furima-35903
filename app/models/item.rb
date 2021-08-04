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

  with_options presence: true do
    validates :product                                            # 商品名及び商品の説明欄はビューのmaxlengthで文字数を制限してるのでバリデーション記述していない
    validates :product_description
    validates :image
    validates :price, format: { with: /\A[0-9]+\z/ },
                      numericality: { only_integer: true,
                        greater_than: 300, less_than: 10000000 }
  end

  validates :category_id, :status_id, :postage_id, :prefecture_id, :shipping_date_id, numericality: { other_than: 1 , message: "can't be blank" }

end
