class RenameSectorToShare < ActiveRecord::Migration[6.0]
  def change
    rename_column :shares, :sector, :sector_id
  end
end
