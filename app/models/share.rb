class Share < ApplicationRecord
    has_many :share_to_portfolios
    has_many :share_informations
    has_one :scrape_url
end
