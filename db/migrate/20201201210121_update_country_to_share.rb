class UpdateCountryToShare < ActiveRecord::Migration[6.0]
  def change
    rename_column :shares, :country, :country_id
  end
end
