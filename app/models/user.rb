class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable
  validates :nickname, presence: true

  valid_password_ReGex = /(?=.*?[a-z])(?=.*?\d)[a-z\d]/i
  validates :password, length: { minimum: 7 }, format: { with: valid_password_ReGex }

  valid_email_ReGex = /\A\S+@\S+\.\S+\z/
  validates :email, format: { with: valid_email_ReGex }

  has_one :address
  has_one :profile
end
