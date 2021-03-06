class SharesController < ApplicationController
    def index
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
        elsif params[:industry_id].present?
            from = 0
            to = 1000
        else
            from = 0
            to = from + 99 
        end
        
        @shares_index = @shares_index[from..to]

    end


    def new
        @portfolio = Portfolio.find(params[:portfolio_id])
        @share = Share.order("name asc").all
    end

    def show
        @share = Share.find(params[:id])
        @share_informations = @share.share_informations
        @share_price_per_day = {}
        @share_informations.each do |information|
            
            @share_price_per_day[information.date] = information.share_price

        end
        @share_information = @share.share_informations.last
        @share_price_first_january = ShareInformation.where(date: "2021-01-04", share_id: @share.id)
        
    end

    def render_select_shares_sector
        if params[:country_id] == "none" && params[:sector_id] == "none"
            @shares = Share.order("name asc").all
            html_string = render_to_string(partial: "select_shares.html.erb", locals: {shares: @shares})
            render json: {html_string: html_string}
        elsif params[:sector_id] == "none"
            @shares = Share.where(country_id: params[:country_id])
            html_string = render_to_string(partial: "select_shares.html.erb", locals: {shares: @shares})
            render json: {html_string: html_string} 
        elsif params[:country_id] == "none"
            @shares = Share.where(sector_id: params[:sector_id])
            html_string = render_to_string(partial: "select_shares.html.erb", locals: {shares: @shares})
            render json: {html_string: html_string} 
        else
            @shares = Share.where(country_id: params[:country_id], sector_id: params[:sector_id])
            html_string = render_to_string(partial: "select_shares.html.erb", locals: {shares: @shares})
            render json: {html_string: html_string}
        end
    end
end