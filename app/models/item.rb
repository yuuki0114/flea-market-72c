class Item < ApplicationRecord
  #-- 空の場合dbに登録できないようにする
  with_options presence: true do
    validates :name,          null: false
    validates :detail,        null: false
    validates :status,        null: false
    validates :delivery_fee,  null: false
    validates :start_address, null: false
    validates :shipping_date, null: false
    validates :price,         null: false
  end



  #-- 他のテーブルと紐付け
  belongs_to :brand
  belongs_to :category
  has_many   :images

  #-- 複数の画像を登録するための記述
  accepts_nested_attributes_for :images

end