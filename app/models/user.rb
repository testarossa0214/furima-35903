class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :nickname, presence: true
  # validates :email, presence: true, unique: true
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :first_name_zen_kana, presence: true
  validates :last_name_zen_kana, presence: true
  validates :birth_day, presence: true
end
