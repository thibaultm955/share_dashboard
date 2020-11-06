class AddInformationToShare < ActiveRecord::Migration[6.0]
  def change
    add_column :shares, :mnemonic, :string
    add_column :shares, :market, :string
    add_column :shares, :industry, :string
    add_column :shares, :description, :string
  end
end
