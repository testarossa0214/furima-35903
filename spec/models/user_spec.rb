require 'rails_helper'

RSpec.describe User, type: :model do
  before do
    @user = FactoryBot.build(:user)
  end

  describe "ユーザー新規登録" do
    it "nickname、email、password、password_confirmation、苗字、名前、苗字カナ、名前カナ、生年月日があれば登録できる" do
      expect(@user).to be_valid
    end

    it "nicknameが空だと登録できない" do
      @user.nickname = ''
      @user.valid?
      expect(@user.errors.full_messages).to include("Nickname can't be blank")
    end
    
    it "メールアドレスが空だと登録できない" do
      @user.email = ''
      @user.valid?
      expect(@user.errors.full_messages).to include("Email can't be blank")
    end

    it "重複するメールアドレスでは登録できない" do
      @user.save
      another_user = FactoryBot.build(:user)
      another_user.email = @user.email
      another_user.valid?
      expect(another_user.errors.full_messages).to include("Email has already been taken")
    end

    it "メールアドレスは@を含む必要がある" do
      @user.email = 'aaaaa'
      @user.valid?
      expect(@user.errors.full_messages).to include("Email is invalid")
    end

    it "パスワードが空だと登録できない" do
      @user.password = ''
      @user.valid?
      expect(@user.errors.full_messages).to include("Password can't be blank")
    end

    it "パスワードは6文字以上でないと登録できない" do
      @user.password = 'aaaaa'
      @user.valid?
      expect(@user.errors.full_messages).to include("Password is too short (minimum is 6 characters)")
    end

    # it "パスワードは、半角英数字混合での入力が必須である" do 
    #   binding.pry
    #   @user.password = 'aaaaaa'
    #   @user.valid?
    #   expect(@user.errors.full_messages).to include
    # end

    it "パスワードとパスワード（確認）は、値の一致が必須である" do
    binding.pry
      @user.password = 'a1a1a1'
      @user.password_confirmation = 'a2a2a2'
      @user.valid?
      expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
    end
  end

  
#   - お名前(全角)は、名字と名前がそれぞれ必須であること。
# - お名前(全角)は、全角（漢字・ひらがな・カタカナ）での入力が必須であること。
# - お名前カナ(全角)は、名字と名前がそれぞれ必須であること。
# - お名前カナ(全角)は、全角（カタカナ）での入力が必須であること。
# - 生年月日が必須であること。
end
