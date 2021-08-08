class OrderAddress
  include ActiveModel::Model
  attr_accessor :delivery_postalcode, :prefecture_id, :delivery_city, :delivery_address, :delivery_mansion,
                :phone, :order_id, :user, :item

  with_options presence: true do
    validates :delivery_postalcode, format: {with: /\A[0-9]{3}-[0-9]{4}\z/, message: "is invalid. Include hyphen(-)"}
    
    validates :delivery_city
    validates :delivery_address
    validates :phone, format: {with: /\A\d{10}$|^\d{11}\z/}

    validates :order_id
    validates :user
    validates :item
  end
  validates :prefecture_id, numericality: { other_than: 1, message: "can't be blank" }

  def save
    @order = Order.create(user: user, item: item)
    Address.create(delivery_postalcode: delivery_postalcode, prefecture_id: prefecture_id, 
                   delivery_city: delivery_city, delivery_address: delivery_address,
                   delivery_mansion: delivery_mansion, phone: phone, oreder_id: order.id)
  end
end