class AddWebsiteToShareInformation < ActiveRecord::Migration[6.0]
  def change
    add_column :share_informations, :website, :string
  end
end
