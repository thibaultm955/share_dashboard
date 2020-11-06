class CreateScrapeUrls < ActiveRecord::Migration[6.0]
  def change
    create_table :scrape_urls do |t|
      t.string :url
      t.references :share, null: false, foreign_key: true

      t.timestamps
    end
  end
end
