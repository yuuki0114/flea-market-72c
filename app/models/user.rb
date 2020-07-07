class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable
  validates :nickname, presence: true

  valid_password_ReGex = /(?=.*?[a-z])(?=.*?\d)[a-z\d]/i
  validates :password, length: { minimum: 7 }, format: { with: valid_password_ReGex }

  valid_email_ReGex = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, uniqueness: true, format: { with: valid_email_ReGex }

  validates :password, confirmation: true

  has_one :address
  has_one :profile
  has_one :credit_card, dependent: :destroy
end
