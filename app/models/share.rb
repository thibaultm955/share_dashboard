class Share < ApplicationRecord
    has_many :share_to_portfolios
    has_many :share_informations
    has_one :scrape_url
    belongs_to :country
    belongs_to :sector
end
