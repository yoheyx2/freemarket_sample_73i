class AddLastNameToAddresses < ActiveRecord::Migration[5.2]
  def change
    add_column :addresses, :last_name, :string
  end
end
