require 'rails_helper'

RSpec.describe Item, type: :model do
  before do
    @item = FactoryBot.build(:item)
  end

  describe '商品出品' do
    context '商品が出品できるとき' do
      it '商品画像、商品名、商品の説明、カテゴリー、商品の状態、配送料の負担、発送元の地域、発送までの日数、価格があれば出品できる' do
        expect(@item).to be_valid
      end
    end

    context '商品が出品できないとき' do
      it '画像が添付されていないと出品できない' do
          @item.image = nil
          @item.valid?
          expect(@item.errors.full_messages).to include("Image can't be blank")
      end

      it '商品名が空だと出品できない' do
        @item.product = ""
        @item.valid?
        expect(@item.errors.full_messages).to include("Product can't be blank")
      end

      it '商品の説明が空だと出品できない' do
        @item.product_description = ""
        @item.valid?
        expect(@item.errors.full_messages).to include("Product description can't be blank")
      end

      it 'カテゴリーが「---」のままだと出品できない' do
        @item.category_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include("Category can't be blank")
      end

      it '商品の状態が「---」のままだと出品できない' do
        @item.status_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include("Status can't be blank")
      end

      it '配送料の負担が「---」のままだと出品できない' do
        @item.postage_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include("Postage can't be blank")
      end

      it '発送元の地域が「---」のままだと出品できない' do
        @item.prefecture_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include("Prefecture can't be blank")
      end

      it '発送までの日数が「---」のままだと出品できない' do
        @item.shipping_date_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include("Shipping date can't be blank")
      end

      it '価格が空だと登録できない' do
        @item.price = ""
        @item.valid?
        expect(@item.errors.full_messages).to include("Price can't be blank", "Price is invalid", "Price is not a number")
      end

      it '価格が300未満だと出品できない' do
        @item.price = "299"
        @item.valid?
        expect(@item.errors.full_messages).to include("Price must be greater than 300")
      end

      it '価格が9999999以上だと出品できない' do
        @item.price = "10000000"
        @item.valid?
        expect(@item.errors.full_messages).to include("Price must be less than 10000000")
      end
    end
  end
end
