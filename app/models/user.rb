class User < ApplicationRecord
  # Include default devise modules.
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :nickname, presence: true
  validates :email, format: { with: /\A[^@\s]+@[^@\s]+\z/, message: 'は有効なメールアドレスの形式で入力してください' }
  validates :password, format: { with: /\A(?=.*?[a-z])(?=.*?[0-9])/i, message: 'は半角英数字混合で入力してください' }
  validates :last_name, presence: true
  validates :first_name, presence: true
  validates :first_name_kana, presence: true
  validates :last_name_kana, presence: true
end
