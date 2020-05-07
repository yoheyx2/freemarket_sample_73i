class AddLastNameFuriganaToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :last_name_furigana, :string
  end
end
