FactoryBot.define do
  factory :item do
    product { '商品名' }
    product_description { '商品の説明' }
    category_id { 2 }
    status_id { 2 }
    postage_id { 2 }
    prefecture_id { 2 }
    shipping_date_id { 2 }
    price { 1000 }
    association :user

    after(:build) do |item|
      item.image.attach(io: File.open('public/images/test_image.png'), filename: 'test_image.png')
    end
  end
end

