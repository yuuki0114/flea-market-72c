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

  #-- active_hashで定義したデータを読み込む
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to_active_hash :prefecture

  #-- 他のテーブルと紐付け
  belongs_to :brand, optional: true
  accepts_nested_attributes_for :brand
  belongs_to :category
  has_many   :images
  belongs_to :user

  #-- 複数の画像を登録するための記述
  accepts_nested_attributes_for :images
  
end
