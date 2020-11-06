class CreateShareToPortfolios < ActiveRecord::Migration[6.0]
  def change
    create_table :share_to_portfolios do |t|
      t.references :portfolio, null: false, foreign_key: true
      t.references :share, null: false, foreign_key: true

      t.timestamps
    end
  end
end
