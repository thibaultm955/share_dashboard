class AddCommentToShareToPorfolio < ActiveRecord::Migration[6.0]
  def change
    add_column :share_to_portfolios, :comment, :string
  end
end
