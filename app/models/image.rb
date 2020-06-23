class Image < ApplicationRecord

  #-- アップローダーの実装
  mount_uploader :src, ImageUploader

  #-- 他のテーブルと紐付け
  belongs_to :item

end
