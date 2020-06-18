class CreateItems < ActiveRecord::Migration[5.2]
  def change
    create_table :items do |t|
      t.string  :name,          null: false
      t.text    :detail,        null: false
      t.integer :status,        null: false
      t.string  :delivery_fee,  null: false
      t.string  :start_address, null: false
      t.string  :shipping_date, null: false
      t.integer :price,         null: false
      t.timestamps
    end
  end
end
