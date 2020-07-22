class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :omniauthable, omniauth_providers: [:facebook, :google_oauth2]
  validates :nickname, presence: true

  valid_password_ReGex = /(?=.*?[a-z])(?=.*?\d)[a-z\d]/i
  validates :password, length: { minimum: 7 }, format: { with: valid_password_ReGex }

  valid_email_ReGex = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, uniqueness: true, format: { with: valid_email_ReGex }

  validates :password, confirmation: true

  has_one   :address
  has_one   :profile
  has_one :credit_card, dependent: :destroy
  has_many  :items
  has_many :sns_credentials

  def self.from_omniauth(auth)
    sns = SnsCredential.where(provider: auth.provider, uid: auth.uid).first_or_create
    user = sns.user || User.where(email: auth.info.email).first_or_initialize(
      nickname: auth.info.name,
        email: auth.info.email
    )
    if user.persisted?
      sns.user = user
      sns.save
    end
    { user: user, sns: sns }
  end
end
