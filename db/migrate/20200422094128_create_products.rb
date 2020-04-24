class CreateProducts < ActiveRecord::Migration[5.2]
  def change
    create_table :products do |t|
      # t.string :name, null: false
      # t.text :infomation, null: false
      # t.integer :category, null: false
      # t.string :brand
      # t.integer :status, null: false
      # t.integer :delivery_fee, null: false
      # t.integer :ship_form, null: false
      # t.integer :delivery_time, null: false
      # t.integer :price, null: false
      # t.integer :user_id, null: false, foreign_key: true
      t.timestamps
    end
  end
end


