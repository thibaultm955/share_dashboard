class PagesController < ApplicationController
  def home
    @countries = Country.order("name asc").all
    @sectors = Sector.order("name asc").all
    @industry = Industry.order("name asc").all
    if params[:query].present? || params[:sector_id].present? || params[:country_id].present? || params[:industry_id].present? 
        sql_query = "name ILIKE :query"
        if params[:country_id] == "sectors"
            @shares_index = Share.order("name asc").where(sql_query, query: "%#{params[:query]}%")
        elsif params[:sector_id].present? && params[:country_id].present? && params[:industry_id].present?
            @shares_index = Share.order("name asc").where(sql_query, query: "%#{params[:query]}%").where(industry_id: params[:industry_id],sector_id: params[:sector_id], country_id: params[:country_id])
        elsif params[:industry_id].present? && params[:country_id].present?
            @shares_index = Share.order("name asc").where(sql_query, query: "%#{params[:query]}%").where(industry_id: params[:industry_id], country_id: params[:country_id])
        elsif params[:sector_id].present? && params[:industry_id].present?
            @shares_index = Share.order("name asc").where(sql_query, query: "%#{params[:query]}%").where(sector_id: params[:sector_id], industry_id: params[:industry_id])
        elsif params[:sector_id].present?
            @shares_index = Share.order("name asc").where(sql_query, query: "%#{params[:query]}%").where(sector_id: params[:sector_id])            
        elsif params[:country_id].present?
            @shares_index = Share.order("name asc").where(sql_query, query: "%#{params[:query]}%").where(country_id: params[:country_id])
        elsif params[:industry_id].present?
            @shares_index = Share.order("name asc").where(industry: params[:industry_id])
        else
            @shares_index = Share.order("name asc").where(sql_query, query: "%#{params[:query]}%")
        end
      else
        
        @shares = Share.order("name asc").all
        respond_to do |format|
            format.html
            format.json { render json: { shares: @shares } }
        end
        @shares_index = Share.order("name asc").all
      end
    if  (@shares_index.length % 100 > 0 ) 
        @pages =  @shares_index.length / 100 + 1
    else
        @pages =  @shares_index.length / 100
    end

    if params[:page].present?
        from = ( params[:page].to_i - 1 ) * 100
        to = from + 99
    else
        # Start from 0 as the first line is an empty string
        from = 1
        to = from + 98 
    end
    
    @shares_index = @shares_index[from..to]

  end
end
