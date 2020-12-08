class PagesController < ApplicationController
  def home
    @page = Share.new
    @shares = Share.all
    @countries_all = Country.all
    @sectors_all = Sector.all
    @share_names = []
    @countries = []
    @sectors = []
    @shares.each do |share| 
        @share_names << share.name
        @countries << share.country_id
        @sectors << share.sector_id
    end
    @countries = @countries.uniq.sort    
    @sectors = @sectors.uniq.sort    
    @share_names = @share_names.sort
  end
end
