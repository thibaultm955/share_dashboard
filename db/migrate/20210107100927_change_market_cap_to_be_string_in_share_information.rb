class ChangeMarketCapToBeStringInShareInformation < ActiveRecord::Migration[6.0]
  def change
    change_column :share_informations, :market_cap, :string
  end
end
