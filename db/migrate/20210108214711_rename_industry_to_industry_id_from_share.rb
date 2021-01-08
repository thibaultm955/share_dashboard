class RenameIndustryToIndustryIdFromShare < ActiveRecord::Migration[6.0]
  def change
    rename_column :shares, :industry, :industry_id
  end
end
