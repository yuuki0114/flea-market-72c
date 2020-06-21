class Address < ApplicationRecord
  validates :first_name,
            :last_name,
            :first_name_kana,
            :last_name_kana,
            :postal_code,
            :prefectures,
            :municipalities,
            :street_number, presence: true

  belongs_to :user, optional: true
end
