class AddPriceObjectivesToShareToPortfolios < ActiveRecord::Migration[6.0]
  def change
    add_column :share_to_portfolios, :price_objective, :float
  end
end
