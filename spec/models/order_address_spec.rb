require 'rails_helper'

RSpec.describe OrderAddress, type: :model do
  describe '購入情報の保存' do
    before do
      user = FactoryBot.create(:user)
      item = FactoryBot.create(:item)
      @order_address = FactoryBot.build(:order_address, user_id: user.id, item_id: item.id)
      sleep(0.01)
    end

    context '内容に問題がない場合' do
      it '全ての値が正しく入力されていれば保存できること' do
        expect(@order_address).to be_valid
      end

      it '建物名(delivery_mansion)が空でも保存できること' do
        @order_address.delivery_mansion = ''
        expect(@order_address).to be_valid
      end
    end

    context '内容に問題がある場合' do
      it '郵便番号(delivery_postalcode)が空だと保存できないこと' do
      @order_address.delivery_postalcode = ''
      @order_address.valid?
      expect(@order_address.errors.full_messages).to include("Delivery postalcode can't be blank", "Delivery postalcode is invalid. Include hyphen(-)")
      end

      it '郵便番号(delivery_postalcode)が半角のハイフンを含んだ正しい形式でないと保存できないこと' do
        @order_address.delivery_postalcode = '1234567'
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("Delivery postalcode is invalid. Include hyphen(-)")
      end

      it '都道府県(prefecture_id > 1)を選択していないと保存できないこと' do
        @order_address.prefecture_id = 1
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("Prefecture can't be blank")
      end

      it '市区町村(delivery_city)が空だと保存できないこと' do
        @order_address.delivery_city = ''
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("Delivery city can't be blank")
      end

      it '番地(delivery_address)が空だと保存ができないこと' do
        @order_address.delivery_address = ''
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("Delivery address can't be blank")
      end

      it '電話番号(phone)が空だと保存ができないこと' do
        @order_address.phone = ''
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("Phone can't be blank", "Phone is invalid")
      end

      it '電話番号が9桁だと保存ができないこと' do
        @order_address.phone = '123456789'
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("Phone is invalid")
      end

      it '電話番号が12桁だと保存ができないこと' do
        @order_address.phone = '090123456789'
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("Phone is invalid")
      end

      it '電話番号は全角数字では保存できないこと' do
        @order_address.phone = '０９０１２３４５６７８'
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("Phone is invalid")
      end

      it '電話番号は英字があると保存できないこと' do
        @order_address.phone = '090a1a2a3a4'
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("Phone is invalid")
      end
    end
  end
end