class AddFirstNameFuriganaToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :first_name_furigana, :string
  end
end
