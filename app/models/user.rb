class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :nickname, presence: true
  validates :email, uniqueness: true
  # validates :password, format: { with: /\A[a-zA-Z0-9]+\z/, message: '6文字以上の半角英数字で入力してください' }

  with_options presence: true, format: { with: /\A[ぁ-んァ-ヶ一-龥々]/ } do
    validates :first_name
    validates :last_name
  end

  with_options presence: true, format: { with: /\A[ァ-ヶーー]+\z/ } do
    validates :first_name_zen_kana
    validates :last_name_zen_kana
  end

  validates :birth_day, presence: true


end

# /\A[a-zA-Z0-9]+\z/
