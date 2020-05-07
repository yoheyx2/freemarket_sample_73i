class AddFirstNameFuriganaToAddresses < ActiveRecord::Migration[5.2]
  def change
    add_column :addresses, :first_name_furigana, :string
  end
end
