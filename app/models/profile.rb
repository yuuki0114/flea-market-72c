class Profile < ApplicationRecord
  validates :first_name,
            :last_name,
            :first_name_kana,
            :last_name_kana,
            :birthday, presence: true

  valid_name_ReGex = /\A[一-龥ぁ-ん]/
  validates :first_name, :last_name, format: { with: valid_name_ReGex }

  valid_name_kana_ReGex = /\A[ァ-ヶー－]+\z/
  validates :first_name_kana, :last_name_kana, format: { with: valid_name_kana_ReGex }

  belongs_to :user, optional: true
end
