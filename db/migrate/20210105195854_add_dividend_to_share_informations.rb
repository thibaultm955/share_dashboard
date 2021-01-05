class AddDividendToShareInformations < ActiveRecord::Migration[6.0]
  def change
    add_column :share_informations, :dividend, :string
  end
end
