class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :nickname, presence: true
  validates :email, uniqueness: true
  validates :password, format: { with: /\A[a-zA-Z0-9]+\z/, message: '6文字以上の半角英数字で入力してください' }
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :birth_day, presence: true

  with_options presence: true, format: { with: /\A[ァ-ヶー-]+\z/, message: '全角カナで入力してください' } do
    validates :first_name_zen_kana 
    validates :last_name_zen_kana
  end
end


/\A[a-zA-Z0-9]+\z/