FactoryBot.define do
  factory :order_address do
    token {"tok_abcdefghijk00000000000000000"}
    # order_id { 1 }
    delivery_postalcode { '123-4567' }
    prefecture_id { 2 }
    delivery_city { '港区六本木' }
    delivery_address { '1-1' }
    delivery_mansion { '六本木ヒルズ100F' }
    phone { '09011112222' }
    
    # item_id { 1 } 
    # user_id { 1 }
  end
end