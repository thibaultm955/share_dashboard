class AddNameToSector < ActiveRecord::Migration[6.0]
  def change
    add_column :sectors, :name, :string
  end
end
