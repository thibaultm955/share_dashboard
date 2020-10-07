class AddInformationToShareInformation < ActiveRecord::Migration[6.0]
  def change
    add_column :share_informations, :currency, :string
    add_column :share_informations, :volume, :bigint
    add_column :share_informations, :market_cap, :bigint
    add_column :share_informations, :beta, :bigint
    add_column :share_informations, :pe, :bigint
    add_column :share_informations, :eps, :bigint
  end
end
