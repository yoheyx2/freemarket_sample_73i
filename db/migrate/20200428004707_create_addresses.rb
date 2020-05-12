class CreateAddresses < ActiveRecord::Migration[5.2]
  def change
    create_table :addresses do |t|
      t.integer :postal_code, null: false
      t.integer :prefecture_id, null: false
      t.string :city, null: false
      t.string :address, null: false
      t.string :other
      t.string :phone_number
      t.integer :user_id, null: false, foreign_key: true
      t.timestamps
    end
  end
end
