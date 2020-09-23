class ShareToPortfolio < ApplicationRecord
  belongs_to :portfolio
  belongs_to :share
end
