class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

         
  with_options presence: true do

    validates :nickname
    # validates :email, uniqueness: true
    # validates :password, format: { with: /\A[a-zA-Z0-9]+\z/, message: '6文字以上の半角英数字で入力してください' }

    with_options format: { with: /(?=.*[a-zA-Z])(?=.*\d)[a-zA-Z\d]/ } do
      validates :password
    end

    with_options format: { with: /\A[ぁ-んァ-ヶ一-龥々ー]+\z/ } do
      validates :first_name
      validates :last_name
    end

    with_options format: { with: /\A[ァ-ヶー－]+\z/ } do
      validates :first_name_zen_kana
      validates :last_name_zen_kana
    end

    validates :birth_day

  end
end

# /\A[a-zA-Z0-9]+\z/
# メッセージオプションをつけていないのでエラー文はデフォルトのまま。変更したときはuser_specのエラー文も変更する。
