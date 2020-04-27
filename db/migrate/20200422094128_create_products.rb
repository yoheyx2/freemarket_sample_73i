class CreateProducts < ActiveRecord::Migration[5.2]
  def change
    create_table :products do |t|
      t.string :name, null: false
      t.text :infomation, null: false
      t.string :category, null: false
      t.string :brand
      t.string :status, null: false
      t.string :delivery_fee, null: false
      t.string :ship_form, null: false
      t.integer :delivery_time, null: false
      t.integer :price, null: false
      t.integer :user_id, null: false, foreign_key: true
      t.timestamps
    end
  end
end


