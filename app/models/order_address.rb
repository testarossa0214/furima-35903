class OrderAddress
  include ActiveModel::Model
  attr_accessor :delivery_postalcode, :prefecture_id, :delivery_city, :delivery_address, :delivery_mansion,
                :phone, :user_id, :item_id, :token

  with_options presence: true do
    validates :delivery_postalcode, format: { with: /\A[0-9]{3}-[0-9]{4}\z/, message: 'はハイフン(-)を含めてください' }

    validates :delivery_city
    validates :delivery_address
    validates :phone, format: { with: /\A\d{10}$|^\d{11}\z/ }

    validates :user_id
    validates :item_id
    validates :token
  end
  validates :prefecture_id, numericality: { other_than: 1, message: "を入力してください" }

  def save
    order = Order.create(user_id: user_id, item_id: item_id)
    Address.create(delivery_postalcode: delivery_postalcode, prefecture_id: prefecture_id,
                   delivery_city: delivery_city, delivery_address: delivery_address,
                   delivery_mansion: delivery_mansion, phone: phone, order_id: order.id)
  end
end
