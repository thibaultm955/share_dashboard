# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

require 'nokogiri'
require 'open-uri'
require 'csv'

countries = [
    "Australia", "Belgium", "Czech Republic", "Finland", "France", "Germany", "Italy", "Luxembourg", "Netherlands", "Norway", "Portugal", "Spain", "Sweden", "Switzerland", "United Kingdom", "United States", "Russia", "Turkey", "Ukraine", "Poland", "Romania", "Kazakhstan", "Greece", "Azerbaijan", "Hungary", "Belarus", "Austria", "Bulgaria", "Serbia", "Denmark", "Slovakia", "Ireland", "Croatia", "Georgia", "Bosnia and Herzegovina", "Armenia", "Albania", "Lithuania", "Moldova", "North Macedonia", "Slovenia", "Latvia", "Kosovo", "Estonia", "Cyprus", "Canada", "Israel", "Brazil", "Mexico","Japan","South Africa"
]

sectors = ["Basic Materials", "Communication Services", "Consumer Cyclical", "Consumer Defensive", "Energy", "Financial Services", "Healthcare", "Industrials", "Real Estate", "Technology", "Utilities"]

industries = ["Advertising Agencies", "Aerospace & Defense", "Agricultural Inputs", "Airlines", "Airports & Air Services", "Aluminum", "Apparel Manufacturing", "Apparel Retail", "Asset Management", "Auto & Truck Dealerships", "Auto Manufacturers",
                "Auto Parts", "Banks—Diversified", "Banks—Regional", "Beverages—Brewers", "Beverages—Non-Alcoholic", "Beverages—Wineries & Distilleries", "Biotechnology", "Broadcasting", "Building Materials", "Building Products & Equipment",
                "Business Equipment & Supplies", "Capital Markets", "Chemicals", "Coking Coal", "Communication Equipment", "Computer Hardware", "Confectioners", "Conglomerates", "Consulting Services", "Consumer Electronics", "Copper", "Credit Services",
                "Department Stores", "Diagnostics & Research", "Discount Stores", "Drug Manufacturers—General", "Drug Manufacturers—Specialty & Generic", "Education & Training Services", "Electrical Equipment & Parts", "Electronic Components",
                "Electronic Gaming & Multimedia", "Electronics & Computer Distribution", "Engineering & Construction", "Entertainment", "Farm & Heavy Construction Machinery", "Farm Products", "Financial Conglomerates", "Financial Data & Stock Exchanges",
                "Food Distribution", "Footwear & Accessories", "Furnishings, Fixtures & Appliances", "Gambling", "Gold", "Grocery Stores", "Health Information Services", "Healthcare Plans", "Home Improvement Retail", "Household & Personal Products", 
                "Industrial Distribution", "Information Technology Services", "Infrastructure Operations", "Insurance Brokers", "Insurance—Diversified", "Insurance—Life", "Insurance—Property & Casualty", "Insurance—Reinsurance", "Insurance—Specialty",
                "Integrated Freight & Logistics", "Internet Content & Information", "Internet Retail", "Leisure", "Lodging", "Lumber & Wood Production", "Luxury Goods", "Marine Shipping", "Medical Care Facilities", "Medical Devices", "Medical Distribution",
                "Medical Instruments & Supplies", "Metal Fabrication", "Mortgage Finance", "Oil & Gas Drilling", "Oil & Gas E&P", "Oil & Gas Equipment & Services", "Oil & Gas Integrated", "Oil & Gas Midstream", "Oil & Gas Refining & Marketing",
                "Other Industrial Metals & Mining", "Other Precious Metals & Mining", "Packaged Foods", "Packaging & Containers", "Paper & Paper Products", "Personal Services", "Pharmaceutical Retailers", "Pollution & Treatment Controls", "Publishing",
                "REIT—Diversified", "REIT—Healthcare Facilities", "REIT—Hotel & Motel", "REIT—Industrial", "REIT—Office", "REIT—Residential", "REIT—Retail", "REIT—Specialty", "Railroads", "Real Estate Services", "Real Estate—Development", "Real Estate—Diversified",
                "Recreational Vehicles", "Rental & Leasing Services", "Residential Construction", "Resorts & Casinos", "Restaurants", "Scientific & Technical Instruments", "Security & Protection Services", "Semiconductor Equipment & Materials", "Semiconductors",
                "Shell Companies", "Software—Application", "Software—Infrastructure", "Solar", "Specialty Business Services", "Specialty Chemicals", "Specialty Industrial Machinery", "Specialty Retail", "Staffing & Employment Services", "Steel", "Telecom Services",
                "Textile Manufacturing", "Thermal Coal", "Tobacco", "Tools & Accessories", "Travel Services", "Utilities—Diversified", "Utilities—Independent Power Producers", "Utilities—Regulated Electric", "Utilities—Regulated Gas", "Utilities—Regulated Water",
                "Utilities—Renewable", "Waste Management"
            ]

countries.each do |country|
    if Country.where(:name => country) == []
        country_created = Country.new(name: country)
        country_created.save
    end
end

sectors.each do |sector|
    if Sector.where(:name => sector) == []
        sector_created = Sector.new(name: sector)
        sector_created.save
    end
end

industries.each do |industry|
    if Industry.where(:name => industry) == []
        industry_created = Industry.new(name: industry)
        industry_created.save
    end
end
# Europe
urls = CSV.parse(File.read("cleaned_url.csv"), headers: true)
# Nasdaq
# urls = CSV.parse(File.read("nasdaq_url.csv"), headers: true)

time = Time.now
date_today = time.strftime("%d/%m/%Y")
iterator = 0

urls.each do |url|
    url_0 = url

    # Europe
    url = url[0]
    # Nasdaq
    # url = url[1]
    
    puts url
    begin
        doc = Nokogiri::HTML(URI.open(url,
        "User-Agent" => "Zombies from Space"))
        values = {}
        name, mnemonic, share_price, variation, currency, market, volume, market_cap, beta, pe, eps, number_of_shares, country, sector, industry, description, dividend, website = "","", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", ""
        if doc.css('h1.D\(ib\)').inner_html == ""

        else
            iterator += 1
            puts iterator
            puts "name"
            doc.css('h1.D\(ib\)').each do |link|
                name = link.content.split(" (")[0]
                mnemonic = link.content.split(" (")[1].split(")")[0]
            end
            puts name
            # if share already exist, keep it
            if Share.where(:name => name) == []
                puts "share price"
                doc.css('.Fz\(36px\)').each do |link|
                share_price = link.content.gsub(",", "")
                end
        
                puts "Variation"
                doc.css('span.Trsdu\(0\.3s\):nth-child(2)').each do |link|
                variation = link.content.split("(")[1].split(")")[0]
                end
        
                puts "Market + Currency"
                doc.css('.Mt\(-5px\) > div:nth-child(2) > span:nth-child(1)').each do |link|
                    currency = link.content.split("Currency in ")[1]
                    market = link.content.split(" -")[0]
                end 
        
                puts "Volume"
                doc.css('div.ie-7_D\(i\):nth-child(1) > table:nth-child(1) > tbody:nth-child(1) > tr:nth-child(7) > td:nth-child(2) > span:nth-child(1)').each do |link|
                    volume = link.content
                end
        
                puts "Market Cap"
                doc.css('table.M\(0\):nth-child(1) > tbody:nth-child(1) > tr:nth-child(1) > td:nth-child(2) > span:nth-child(1)').each do |link|
                    market_cap = link.content
                end
        
                puts "Beta"
                doc.css('table.M\(0\):nth-child(1) > tbody:nth-child(1) > tr:nth-child(2) > td:nth-child(2) > span:nth-child(1)').each do |link|
                    beta = link.content
                end
        
                puts "PE"
                doc.css('table.M\(0\):nth-child(1) > tbody:nth-child(1) > tr:nth-child(3) > td:nth-child(2) > span:nth-child(1)').each do |link|
                    pe = link.content
                end
        
                puts "EPS"
                doc.css('table.M\(0\):nth-child(1) > tbody:nth-child(1) > tr:nth-child(4) > td:nth-child(2) > span:nth-child(1)').each do |link|
                    eps = link.content
                end

                puts "Dividend"
                doc.css('table.M\(0\):nth-child(1) > tbody:nth-child(1) > tr:nth-child(6) > td:nth-child(2)').each do |link|
                    dividend = link.content
                end

                
        
                # Statistics
                
                splitted = url.split("?")
                stat_url = splitted[0] + '/key-statistics?' + splitted[1]
                docs = Nokogiri::HTML(URI.open(stat_url,
                "User-Agent" => "Zombies from Space"))
                puts "Outstanding shares"
                docs.css('div.Pstart\(20px\) > div:nth-child(2) > div:nth-child(1) > div:nth-child(1) > table:nth-child(2) > tbody:nth-child(1) > tr:nth-child(3) > td:nth-child(2)').each do |link|
                    number_of_shares = link.content
                end
        
                #Profile
                profile_url = splitted[0] + '/profile?' + splitted[1]
                docp = Nokogiri::HTML(URI.open(profile_url,
                "User-Agent" => "Zombies from Space"))
                puts "Country"
                docp.css('p.D\(ib\):nth-child(1)').each do |link|
                    country = link.inner_html.gsub("<!--", "||").gsub("-->", "||").split("||")[-3]
                    puts country
                end
        
                puts "Sector"
                docp.css('span.Fw\(600\):nth-child(2)').each do |link|
                    sector = link.content
                end
        
                puts "Industry"
                docp.css('span.Fw\(600\):nth-child(5)').each do |link|
                    industry = link.content
                end
        
                puts "Description"
                docp.css('p.Mt\(15px\)').each do |link|
                    description = link.content
                end 

                puts "Website"
                docp.css('a.C\(\$linkColor\):nth-child(6)').each do |link|
                    website = link.content
                end

                values[name]  = {:share_price => share_price, :mnemonic => mnemonic, :variation => variation, :currency => currency, :market => market, :volume => volume, :market_cap => market_cap, :beta => beta, :pe => pe, :eps => eps, :number_of_shares => number_of_shares, :country => country, :sector => sector, :industry => industry, :description => description, :date => date_today, :url => url, :dividend => dividend, :website => website}
                sector = Sector.where(name: values[name][:sector])[0]
                
                key = name
                country = Country.where(name: values[name][:country])[0]
                puts (key)
                industry = Industry.where(name: values[name][:industry])[0]
                share = Share.new(:name => key, :currency => values[name][:currency], :mnemonic => values[name][:mnemonic], :market => values[name][:market], :description => values[name][:description])
                share.country = country
                share.sector = sector
                share.industry = industry
                share.save
                share = Share.where(:name => key)[0]
                scrape_url = ScrapeUrl.new(:url => values[name][:url])
                scrape_url.share = share
                scrape_url.save
                share_information = ShareInformation.new(:date => values[name][:date], :share_price => values[name][:share_price], :variation => values[name][:variation], :number_of_shares => values[name][:number_of_shares], :currency => values[name][:currency], :volume => values[name][:volume], :market_cap => values[name][:market_cap], :beta => values[name][:beta], :pe => values[name][:pe], :eps => values[name][:eps], :dividend => values[name][:dividend], :website => values[name][:website])
                share_information.share = share
                share_information.save
            else
                share = Share.where(:name => name)[0]
                values[name]  = {:date => date_today}
                # check if information already uploaded
                if share.share_informations.where(:date => values[name][:date]).ids.empty? == false    
                    puts "hey baby"
                else
                    share = Share.where(:name => name)[0]
                    puts "share price"
                    doc.css('.Fz\(36px\)').each do |link|
                    share_price = link.content.gsub(",", "")
                    end

                    puts "Variation"
                    doc.css('span.Trsdu\(0\.3s\):nth-child(2)').each do |link|
                    variation = link.content.split("(")[1].split(")")[0]
                    end

                    puts "Market + Currency"
                    doc.css('.Mt\(-5px\) > div:nth-child(2) > span:nth-child(1)').each do |link|
                        currency = link.content.split("Currency in ")[1]
                        market = link.content.split(" -")[0]
                    end 

                    puts "Volume"
                    doc.css('div.ie-7_D\(i\):nth-child(1) > table:nth-child(1) > tbody:nth-child(1) > tr:nth-child(7) > td:nth-child(2) > span:nth-child(1)').each do |link|
                        volume = link.content
                    end

                    puts "Market Cap"
                    doc.css('table.M\(0\):nth-child(1) > tbody:nth-child(1) > tr:nth-child(1) > td:nth-child(2) > span:nth-child(1)').each do |link|
                        market_cap = link.content
                    end

                    puts "Beta"
                    doc.css('table.M\(0\):nth-child(1) > tbody:nth-child(1) > tr:nth-child(2) > td:nth-child(2) > span:nth-child(1)').each do |link|
                        beta = link.content
                    end

                    puts "PE"
                    doc.css('table.M\(0\):nth-child(1) > tbody:nth-child(1) > tr:nth-child(3) > td:nth-child(2) > span:nth-child(1)').each do |link|
                        pe = link.content
                    end

                    puts "EPS"
                    doc.css('table.M\(0\):nth-child(1) > tbody:nth-child(1) > tr:nth-child(4) > td:nth-child(2) > span:nth-child(1)').each do |link|
                        eps = link.content
                    end

                    puts "Dividend"
                    doc.css('table.M\(0\):nth-child(1) > tbody:nth-child(1) > tr:nth-child(6) > td:nth-child(2)').each do |link|
                        dividend = link.content
                    end

                    # Statistics
                    
                    splitted = url.split("?")
                    stat_url = splitted[0] + '/key-statistics?' + splitted[1]
                    docs = Nokogiri::HTML(URI.open(stat_url,
                    "User-Agent" => "Zombies from Space"))
                    puts "Outstanding shares"
                    docs.css('div.Pstart\(20px\) > div:nth-child(2) > div:nth-child(1) > div:nth-child(1) > table:nth-child(2) > tbody:nth-child(1) > tr:nth-child(3) > td:nth-child(2)').each do |link|
                        number_of_shares = link.content
                    end

                    #Profile
                    profile_url = splitted[0] + '/profile?' + splitted[1]
                    docp = Nokogiri::HTML(URI.open(profile_url,
                    "User-Agent" => "Zombies from Space"))
                    puts "Country"
                    docp.css('p.D\(ib\):nth-child(1)').each do |link|
                        country = link.inner_html.gsub("<!--", "||").gsub("-->", "||").split("||")[-3]
                    end

                    puts "Sector"
                    docp.css('span.Fw\(600\):nth-child(2)').each do |link|
                        sector = link.content
                    end

                    puts "Industry"
                    docp.css('span.Fw\(600\):nth-child(5)').each do |link|
                        industry = link.content
                    end

                    puts "Description"
                    docp.css('p.Mt\(15px\)').each do |link|
                        description = link.content
                    end

                    puts "Website"
                    docp.css('a.C\(\$linkColor\):nth-child(6)').each do |link|
                        website = link.content
                    end
                    

                    values[name]  = {:share_price => share_price, :mnemonic => mnemonic, :variation => variation, :currency => currency, :market => market, :volume => volume, :market_cap => market_cap, :beta => beta, :pe => pe, :eps => eps, :number_of_shares => number_of_shares, :country => country, :sector => sector, :industry => industry, :description => description, :date => date_today, :url => url, :dividend => dividend, :website => website}
                    puts ""
                    puts values
                    puts ""
                    scrape_url = ScrapeUrl.new(:url => values[name][:url])
                    scrape_url.share = share
                    scrape_url.save
                    share_information = ShareInformation.new(:date => values[name][:date], :share_price => values[name][:share_price], :variation => values[name][:variation], :number_of_shares => values[name][:number_of_shares], :currency => values[name][:currency], :volume => values[name][:volume], :market_cap => values[name][:market_cap], :beta => values[name][:beta], :pe => values[name][:pe], :eps => values[name][:eps], :dividend => values[name][:dividend], :website => values[name][:website])
                    share_information.share = share
                    share_information.save
                end
            end 
        end
    rescue Zlib::BufError
        puts " "
        puts " "
        puts " "
        puts " "
        puts " "
        puts " "
        puts " "
        puts " "
        puts " "
        puts " "
        puts " "
        puts " "
        puts "Got a BufError"
        puts " "
        puts " "
        puts " "
        puts " "
        puts " "
        puts " "
        puts " "
        puts " "
        puts " "
        puts " "
        puts " "
        puts " "
        puts " "
        puts " "
        sleep(100)
    rescue Net::OpenTimeout
        puts " "
        puts " "
        puts " "
        puts " "
        puts " "
        puts " "
        puts " "
        puts " "
        puts " "
        puts " "
        puts " "
        puts " "
        puts "Got an Open Timeout error"
        puts " "
        puts " "
        puts " "
        puts " "
        puts " "
        puts " "
        puts " "
        puts " "
        puts " "
        puts " "
        puts " "
        puts " "
        puts " "
        puts " "
        sleep(100)
        retry
    rescue OpenURI::HTTPError 
        puts " "
        puts " "
        puts " "
        puts " "
        puts " "
        puts " "
        puts " "
        puts " "
        puts " "
        puts " "
        puts " "
        puts " "
        puts "Got an HTTP error"
        puts " "
        puts " "
        puts " "
        puts " "
        puts " "
        puts " "
        puts " "
        puts " "
        puts " "
        puts " "
        puts " "
        puts " "
        puts " "
        puts " "
        sleep(100)
        retry
    rescue PG::ConnectionBad
        puts " "
        puts " "
        puts " "
        puts " "
        puts " "
        puts " "
        puts " "
        puts " "
        puts " "
        puts " "
        puts " "
        puts " "
        puts "Got a BufError"
        puts " "
        puts " "
        puts " "
        puts " "
        puts " "
        puts " "
        puts " "
        puts " "
        puts " "
        puts " "
        puts " "
        puts " "
        puts " "
        puts " "
        sleep(100)
    end
    sleep(0.01)
end




