class CreateAddresses < ActiveRecord::Migration[5.2]
  def change
    create_table :addresses do |t|
      t.string      :first_name,             null: false
      t.string      :last_name,              null: false
      t.string      :first_name_kana,        null: false
      t.string      :last_name_kana,         null: false
      t.string      :postal_code,            null: false
      t.integer     :prefectures,            null: false
      t.string      :municipalities,         null: false
      t.string      :street_number,          null: false
      t.string      :detail_building
      t.string      :telephone_number
      t.references  :user,                null: false, foreign_key:true
      t.timestamps
    end
  end
end
