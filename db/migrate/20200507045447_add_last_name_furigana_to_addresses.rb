class AddLastNameFuriganaToAddresses < ActiveRecord::Migration[5.2]
  def change
    add_column :addresses, :last_name_furigana, :string
  end
end
