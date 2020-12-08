# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

require 'nokogiri'
require 'open-uri'

countries = ["Australia", "Belgium", "Finland", "France", "Germany", "Italy", "Luxembourg", "Norway", "Sweden", "Switzerland", "United Kingdom"]

countries.each do |country|
    if Country.where(:name => country) == []
        country_created = Country.new(name: country)
        country_created.save
    end
end

sectors = ["Basic Materials", "Communication Services", "Consumer Cyclical", "Consumer Defensive", "Energy", "Financial Services", "Healthcare", "Industrials", "Real Estate", "Technology", "Utilities"]

sectors.each do |sector|
    if Sector.where(:name => sector) == []
        sector_created = Sector.new(name: sector)
        sector_created.save
    end
end


urls_old = [
'https://finance.yahoo.com/quote/TEM1V.HE?p=TEM1V.HE', 'https://finance.yahoo.com/quote/MLMAD.PA?p=MLMAD.PA', 
'https://finance.yahoo.com/quote/LACR.PA?p=LACR.PA','https://finance.yahoo.com/quote/TEK.L?p=TEK.L',
'https://finance.yahoo.com/quote/ALFRE.PA?p=ALFRE.PA', 'https://finance.yahoo.com/quote/LSAI.L?p=LSAI.L',
'https://finance.yahoo.com/quote/ALINV.PA?p=ALINV.PA', 'https://finance.yahoo.com/quote/ALTEV.PA?p=ALTEV.PA',
'https://finance.yahoo.com/quote/EPR.OL?p=EPR.OL', 'https://finance.yahoo.com/quote/ALP.PA?p=ALP.PA',
'https://finance.yahoo.com/quote/ALSTW.PA?p=ALSTW.PA', 'https://finance.yahoo.com/quote/ALI2S.PA?p=ALI2S.PA',
'https://finance.yahoo.com/quote/CBOT.PA?p=CBOT.PA', 'https://finance.yahoo.com/quote/SDT.PA?p=SDT.PA',
'https://finance.yahoo.com/quote/ALTXC.PA?p=ALTXC.PA','https://finance.yahoo.com/quote/ALEZV.PA?p=ALEZV.PA',
'https://finance.yahoo.com/quote/ALMIC.PA?p=ALMIC.PA', 'https://finance.yahoo.com/quote/WDI.DE?p=WDI.DE',
'https://finance.yahoo.com/quote/ALPHS.PA?p=ALPHS.PA', 'https://finance.yahoo.com/quote/TXT.MI?p=TXT.MI',
'https://finance.yahoo.com/quote/ALGAU.PA?p=ALGAU.PA', 'https://finance.yahoo.com/quote/TIDE.L?p=TIDE.L',
'https://finance.yahoo.com/quote/BST.L?p=BST.L', 'https://finance.yahoo.com/quote/ALBDM.PA?p=ALBDM.PA',
'https://finance.yahoo.com/quote/ALESK.PA?p=ALESK.PA', 'https://finance.yahoo.com/quote/IWG.L?p=IWG.L',
'https://finance.yahoo.com/quote/ALINS.PA?p=ALINS.PA', 'https://finance.yahoo.com/quote/SOG.PA?p=SOG.PA',
'https://finance.yahoo.com/quote/EOS.PA?p=EOS.PA', 'https://finance.yahoo.com/quote/ALMEC.PA?p=ALMEC.PA',
'https://finance.yahoo.com/quote/IPSEY?p=IPSEY', 'https://finance.yahoo.com/quote/BLC.PA?p=BLC.PA',
'https://finance.yahoo.com/quote/CLA.PA?p=CLA.PA', 'https://finance.yahoo.com/quote/MLERO.PA?p=MLERO.PA',
'https://finance.yahoo.com/quote/MLCHE.PA?p=MLCHE.PA', 'https://finance.yahoo.com/quote/ALFOC.PA?p=ALFOC.PA',
'https://finance.yahoo.com/quote/UHR.SW?p=UHR.SW', 'https://finance.yahoo.com/quote/ALDIE.PA?p=ALDIE.PA',
'https://finance.yahoo.com/quote/BALYO.PA?p=BALYO.PA', 'https://finance.yahoo.com/quote/ALS30.PA?p=ALS30.PA', 
'https://finance.yahoo.com/quote/ALWEC.PA?p=ALWEC.PA', 'https://finance.yahoo.com/quote/ERF.PA?p=ERF.PA',
'https://finance.yahoo.com/quote/ABEO.PA?p=ABEO.PA', 'https://finance.yahoo.com/quote/DBG.PA?p=DBG.PA',
'https://finance.yahoo.com/quote/ASP.PA?p=ASP.PA', 'https://finance.yahoo.com/quote/RIB.PA?p=RIB.PA',
'https://finance.yahoo.com/quote/ALWIT.PA?p=ALWIT.PA', 'https://finance.yahoo.com/quote/ALVIV.PA?p=ALVIV.PA',
'https://finance.yahoo.com/quote/GOE.PA?p=GOE.PA', 'https://finance.yahoo.com/quote/ECASA.PA?p=ECASA.PA',
'https://finance.yahoo.com/quote/GV.PA?p=GV.PA', 'https://finance.yahoo.com/quote/CAPLI.PA?p=CAPLI.PA',
'https://finance.yahoo.com/quote/TVLY.PA?p=TVLY.PA', 'https://finance.yahoo.com/quote/KEY.PA?p=KEY.PA',
'https://finance.yahoo.com/quote/AKW.PA?p=AKW.PA', 'https://finance.yahoo.com/quote/SII.PA?p=SII.PA',
'https://finance.yahoo.com/quote/XFAB.PA?p=XFAB.PA', 'https://finance.yahoo.com/quote/HOP.PA?p=HOP.PA',
'https://finance.yahoo.com/quote/ECONB.BR?p=ECONB.BR', 'https://finance.yahoo.com/quote/ALDUB.PA?p=ALDUB.PA',
'https://finance.yahoo.com/quote/ROTH.PA?p=ROTH.PA', 'https://finance.yahoo.com/quote/CGG.PA?p=CGG.PA',
'https://finance.yahoo.com/quote/KOMP.OL?p=KOMP.OL', 'https://finance.yahoo.com/quote/OXB.L?p=OXB.L',
'https://finance.yahoo.com/quote/ELK.OL?p=ELK.OL', 'https://finance.yahoo.com/quote/FKRAFT.OL?p=FKRAFT.OL',
'https://finance.yahoo.com/quote/ACSO.L?p=ACSO.L', 'https://finance.yahoo.com/quote/ELAN-B.ST?p=ELAN-B.ST',
'https://finance.yahoo.com/quote/NRC.OL?p=NRC.OL', 'https://finance.yahoo.com/quote/NET.L?p=NET.L',
'https://finance.yahoo.com/quote/CER.L?p=CER.L', 'https://finance.yahoo.com/quote/ELCO.L?p=ELCO.L',
'https://finance.yahoo.com/quote/ACT.L?p=ACT.L', 'https://finance.yahoo.com/quote/UNG.L?p=UNG.L',
'https://finance.yahoo.com/quote/CKT.L?p=CKT.L', 'https://finance.yahoo.com/quote/ASAI.ST?p=ASAI.ST',
'https://finance.yahoo.com/quote/ALKAL.PA?p=ALKAL.PA', 'https://finance.yahoo.com/quote/MNO.L?p=MNO.L',
'https://finance.yahoo.com/quote/OSI.L?p=OSI.L'
]

require 'csv'
urls = CSV.parse(File.read("url_share.csv"), headers: true)


time = Time.now
date_today = time.strftime("%d/%m/%Y")
iterator = 0

urls.each do |url|
    url_0 = url
    url = url[0]
    puts url
    begin
        doc = Nokogiri::HTML(URI.open(url))
        values = {}
        name, mnemonic, share_price, variation, currency, market, volume, market_cap, beta, pe, eps, number_of_shares, country, sector, industry, description = "","", "", "", "", "", "", "", "", "", "", "", "", "", "", ""
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
                share_price = link.content
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
        
                # Statistics
                
                splitted = url.split("?")
                stat_url = splitted[0] + '/key-statistics?' + splitted[1]
                docs = Nokogiri::HTML(URI.open(stat_url))
                puts "Outstanding shares"
                docs.css('div.Pstart\(20px\) > div:nth-child(2) > div:nth-child(1) > div:nth-child(1) > table:nth-child(2) > tbody:nth-child(1) > tr:nth-child(3) > td:nth-child(2)').each do |link|
                    number_of_shares = link.content
                end
        
                #Profile
                profile_url = splitted[0] + '/profile?' + splitted[1]
                docp = Nokogiri::HTML(URI.open(profile_url))
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

                values[name]  = {:share_price => share_price, :mnemonic => mnemonic, :variation => variation, :currency => currency, :market => market, :volume => volume, :market_cap => market_cap, :beta => beta, :pe => pe, :eps => eps, :number_of_shares => number_of_shares, :country => country, :sector => sector, :industry => industry, :description => description, :date => date_today, :url => url}
                sector = Sector.where(name: values[name][:sector])[0]
                key = name
                country = Country.where(name: values[name][:country])[0]
                share = Share.new(:name => key, :currency => values[name][:currency], :mnemonic => values[name][:mnemonic], :market => values[name][:market], :industry => values[name][:industry], :description => values[name][:description])
                share.country = country
                share.sector = sector
                share.save
                share = Share.where(:name => key)[0]
                scrape_url = ScrapeUrl.new(:url => values[name][:url])
                scrape_url.share = share
                scrape_url.save
                share_information = ShareInformation.new(:date => values[name][:date], :share_price => values[name][:share_price], :variation => values[name][:variation], :number_of_shares => values[name][:number_of_shares], :currency => values[name][:currency], :volume => values[name][:volume], :market_cap => values[name][:market_cap], :beta => values[name][:beta], :pe => values[name][:pe], :eps => values[name][:eps])
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
                    share_price = link.content
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

                    # Statistics
                    
                    splitted = url.split("?")
                    stat_url = splitted[0] + '/key-statistics?' + splitted[1]
                    docs = Nokogiri::HTML(URI.open(stat_url))
                    puts "Outstanding shares"
                    docs.css('div.Pstart\(20px\) > div:nth-child(2) > div:nth-child(1) > div:nth-child(1) > table:nth-child(2) > tbody:nth-child(1) > tr:nth-child(3) > td:nth-child(2)').each do |link|
                        number_of_shares = link.content
                    end

                    #Profile
                    profile_url = splitted[0] + '/profile?' + splitted[1]
                    docp = Nokogiri::HTML(URI.open(profile_url))
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
                    values[name]  = {:share_price => share_price, :mnemonic => mnemonic, :variation => variation, :currency => currency, :market => market, :volume => volume, :market_cap => market_cap, :beta => beta, :pe => pe, :eps => eps, :number_of_shares => number_of_shares, :country => country, :sector => sector, :industry => industry, :description => description, :date => date_today, :url => url}
                    puts ""
                    puts values
                    puts ""
                    scrape_url = ScrapeUrl.new(:url => values[name][:url])
                    scrape_url.share = share
                    scrape_url.save
                    share_information = ShareInformation.new(:date => values[name][:date], :share_price => values[name][:share_price], :variation => values[name][:variation], :number_of_shares => values[name][:number_of_shares], :currency => values[name][:currency], :volume => values[name][:volume], :market_cap => values[name][:market_cap], :beta => values[name][:beta], :pe => values[name][:pe], :eps => values[name][:eps])
                    share_information.share = share
                    share_information.save
                end
            end 
        end
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
        puts "Got an error"
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
    end
    sleep(0.01)
end




