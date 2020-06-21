class Profile < ApplicationRecord
  validates :first_name,
            :last_name,
            :first_name_kana,
            :last_name_kana,
            :birthday, presence: true
end
