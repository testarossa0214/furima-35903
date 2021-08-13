class CreateAddresses < ActiveRecord::Migration[6.0]
  def change
    create_table :addresses do |t|
      t.string      :delivery_postalcode,     null: false
      t.integer     :prefecture_id,           null: false
      t.string      :delivery_city,           null: false
      t.string      :delivery_address,        null: false
      t.string      :delivery_mansion
      t.string      :phone,                   null: false
      t.integer     :order_id,                null: false, foreign_key: true
      t.timestamps
    end
  end
end
