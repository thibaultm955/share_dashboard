class CreateShareInformations < ActiveRecord::Migration[6.0]
  def change
    create_table :share_informations do |t|
      t.date :date
      t.float :share_price
      t.float :variation
      t.float :opening
      t.float :highest
      t.float :lowest
      t.bigint :number_of_shares
      t.references :share, null: false, foreign_key: true

      t.timestamps
    end
  end
end
