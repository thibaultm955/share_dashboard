class PagesController < ApplicationController
  def home
    @page = Share.new
    @shares = Share.all
    @countries_all = Country.all
    @share_names = []
    @countries = []
    @sectors = []
    @shares.each do |share| 
        @share_names << share.name
        @countries << share.country_id
        @sectors << share.sector
    end
    @countries = @countries.uniq.sort    
    @sectors = @sectors.uniq.sort    
    @share_names = @share_names.sort
  end
end
