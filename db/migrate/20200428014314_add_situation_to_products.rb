class AddSituationToProducts < ActiveRecord::Migration[5.2]
  def change
    add_column :products, :situation, :integer
  end
end
