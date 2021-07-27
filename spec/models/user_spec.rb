require 'rails_helper'

# バリデーションにてメッセージオプション無しのため、エラー文はデフォルトのまま。エラー文を詳細にする（した）場合はuserモデルのバリデーション確認

RSpec.describe User, type: :model do
  before do
    @user = FactoryBot.build(:user)
  end

  describe 'ユーザー新規登録' do

    context '新規登録できる場合' do
      it 'nickname、email、password、password_confirmation、苗字、名前、苗字カナ、名前カナ、生年月日があれば登録できる' do
        expect(@user).to be_valid
      end
    end
    

    context '新規登録できない場合' do
      it 'nicknameが空だと登録できない' do
        @user.nickname = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Nickname can't be blank")
      end

      it 'メールアドレスが空だと登録できない' do
        @user.email = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Email can't be blank")
      end

      it '重複するメールアドレスでは登録できない' do
        @user.save
        another_user = FactoryBot.build(:user)
        another_user.email = @user.email
        another_user.valid?
        expect(another_user.errors.full_messages).to include('Email has already been taken')
      end

      it 'メールアドレスは、@を含まないと登録できない' do
        @user.email = 'aaaaa'
        @user.valid?
        expect(@user.errors.full_messages).to include('Email is invalid')
      end

      it 'パスワードが空だと登録できない' do
        @user.password = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Password can't be blank")
      end

      it 'パスワードは5文字以下では登録できない' do
        @user.password = 'aaaaa'
        @user.valid?
        expect(@user.errors.full_messages).to include('Password is too short (minimum is 6 characters)')
      end

      it 'パスワードが半角数字のみの場合は登録できない' do
        @user.password = '111111'
        @user.password_confirmation = '111111'
        @user.valid?
        expect(@user.errors.full_messages).to include('Password is invalid', 'Password confirmation is invalid')
      end

      it 'パスワードが半角英字のみの場合は登録できない' do
        @user.password = 'aaaaaa'
        @user.password_confirmation = 'aaaaaa'
        @user.valid?
        expect(@user.errors.full_messages).to include('Password is invalid', 'Password confirmation is invalid')
      end

      it 'パスワードが全角の場合は登録できない' do
        @user.password = 'a１２３４５'
        @user.password_confirmation = 'a１２３４５'
        @user.valid?
        expect(@user.errors.full_messages).to include("Password is invalid", "Password confirmation is invalid")
      end

      it 'パスワードとパスワード（確認）は、値の一致しないと登録できない' do
        @user.password = 'a1a1a1'
        @user.password_confirmation = 'a2a2a2'
        @user.valid?
        expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
      end

      it 'お名前(全角)は、名字が空だと登録できない' do
        @user.last_name = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Last name can't be blank", 'Last name is invalid')
      end

      it 'お名前(全角)は、名前が空だと登録できない' do
        @user.first_name = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("First name can't be blank", 'First name is invalid')
      end

      it 'お名前(全角)の名字は、半角英字だと登録できない' do
        @user.last_name = 'a'
        @user.first_name = 'やまだ'
        @user.valid?
        expect(@user.errors.full_messages).to include('Last name is invalid')
      end

      it 'お名前(全角)の名字は、半角数字だと登録できない' do
        @user.last_name = '1'
        @user.first_name = 'やまだ'
        @user.valid?
        expect(@user.errors.full_messages).to include('Last name is invalid')
      end

      it 'お名前(全角)の名字は、全角数字だと登録できない' do
        @user.last_name = '１'
        @user.first_name = 'やまだ'
        @user.valid?
        expect(@user.errors.full_messages).to include('Last name is invalid')
      end

      it 'お名前(全角)の名前は、半角英字だと登録できない' do
        @user.last_name = 'やまだ'
        @user.first_name = 'a'
        @user.valid?
        expect(@user.errors.full_messages).to include('First name is invalid')
      end

      it 'お名前(全角)の名前は、半角数字だと登録できない' do
        @user.last_name = 'やまだ'
        @user.first_name = '1'
        @user.valid?
        expect(@user.errors.full_messages).to include('First name is invalid')
      end

      it 'お名前(全角)の名前は、全角数字だと登録できない' do
        @user.last_name = 'やまだ'
        @user.first_name = '１'
        @user.valid?
        expect(@user.errors.full_messages).to include('First name is invalid')
      end

      it 'お名前カナ(全角)は、名字が空だと登録できない' do
        @user.last_name_zen_kana = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Last name zen kana can't be blank", 'Last name zen kana is invalid')
      end

      it 'お名前カナ(全角)は、名前が空だと登録できない' do
        @user.first_name_zen_kana = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("First name zen kana can't be blank", 'First name zen kana is invalid')
      end

      it 'お名前カナ(全角)の名字は、ひらがなでは登録できない' do
        @user.last_name_zen_kana = 'やまだ'
        @user.valid?
        expect(@user.errors.full_messages).to include('Last name zen kana is invalid')
      end

      it 'お名前カナ(全角)の名字は、漢字では登録できない' do
        @user.last_name_zen_kana = '山田'
        @user.valid?
        expect(@user.errors.full_messages).to include('Last name zen kana is invalid')
      end

      it 'お名前カナ(全角)の名前は、ひらがなでは登録できない' do
        @user.first_name_zen_kana = 'たかゆき'
        @user.valid?
        expect(@user.errors.full_messages).to include('First name zen kana is invalid')
      end

      it 'お名前カナ(全角)の名前は、漢字では登録できない' do
        @user.first_name_zen_kana = '孝之'
        @user.valid?
        expect(@user.errors.full_messages).to include('First name zen kana is invalid')
      end

      it '生年月日は、誕生年が空では登録できない' do
        @user.birth_day = '-01-01'
        @user.valid?
        expect(@user.errors.full_messages).to include("Birth day can't be blank")
      end

      it '生年月日は、誕生月が空では登録できない' do
        @user.birth_day = '2000--01'
        @user.valid?
        expect(@user.errors.full_messages).to include("Birth day can't be blank")
      end

      it '生年月日は、誕生日が空では登録できない' do
        @user.birth_day = '2000-01-'
        @user.valid?
        expect(@user.errors.full_messages).to include("Birth day can't be blank")
      end
    end
  end
end
