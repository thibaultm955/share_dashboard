class ShareToPortfolio < ApplicationRecord
  belongs_to :portfolio
  belongs_to :share

  # validates_uniqueness_of :share_id, message: "Not cool bro"

end
