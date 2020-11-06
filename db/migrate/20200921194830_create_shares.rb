class CreateShares < ActiveRecord::Migration[6.0]
  def change
    create_table :shares do |t|
      t.string :name
      t.string :sector
      t.string :country
      t.string :currency

      t.timestamps
    end
  end
end
