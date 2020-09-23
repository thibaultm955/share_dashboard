class Portfolio < ApplicationRecord
  belongs_to :user
  has_many :share_to_portfolios
  has_many :shares, through: :share_to_portfolios
end
