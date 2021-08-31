class Item < ApplicationRecord
  has_one :order
  belongs_to :user
  # has_many :comments
  has_many_attached :images

  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :category
  belongs_to :status
  belongs_to :postage
  belongs_to :prefecture
  belongs_to :shipping_date

  with_options presence: true do
    validates :product                                            # 商品名及び商品の説明欄はビューのmaxlengthで文字数を制限してるのでバリデーション記述していない
    validates :product_description
    validates :images
    validates :price, format: { with: /\A[0-9]+\z/ },
                      numericality: { only_integer: true,
                                      greater_than: 299, less_than: 10_000_000 }
  end

  validates :category_id, :status_id, :postage_id, :prefecture_id, :shipping_date_id,
            numericality: { other_than: 1, message: "を入力してください" }
end
