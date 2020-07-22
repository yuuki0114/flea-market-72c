class SnsCredential < ApplicationRecord
  validates :provider, :uid, presence: true 

  belongs_to :user, optional: true
end
