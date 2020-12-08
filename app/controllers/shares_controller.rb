class SharesController < ApplicationController
    def index
        @countries = Country.all
        @sectors = Sector.all
        if params[:query].present? || params[:sector_id].present? || params[:country_id].present?
            
            sql_query = "name ILIKE :query"
            if params[:country_id] == "sectors"
                @shares_index = Share.paginate(:page => params[:page], :per_page => 100).where(sql_query, query: "%#{params[:query]}%")
            elsif params[:sector_id].present? && params[:country_id].present?
                @shares_index = Share.where(sql_query, query: "%#{params[:query]}%").where(sector_id: params[:sector_id], country_id: params[:country_id]).paginate(:page => params[:page], :per_page => 100)
            elsif params[:sector_id].present?
                @shares_index = Share.where(sql_query, query: "%#{params[:query]}%").where(sector_id: params[:sector_id]).paginate(:page => params[:page], :per_page => 100)
            elsif params[:country_id].present?
                @shares_index = Share.where(sql_query, query: "%#{params[:query]}%").where(country_id: params[:country_id]).paginate(:page => params[:page], :per_page => 100)
            else
                @shares_index = Share.paginate(:page => params[:page], :per_page => 100).where(sql_query, query: "%#{params[:query]}%")
            end
          else
            @shares = Share.all
            respond_to do |format|
                format.html
                format.json { render json: { shares: @shares } }
            end
            @shares_index = Share.all.paginate(:page => params[:page], :per_page => 100)
          end
          @shares_index = @shares_index
          
    end


    def new
        @portfolio = Portfolio.find(params[:portfolio_id])
        @share = Share.all
    end

    def show
        @share = Share.find(params[:id])
        @share_informations = @share.share_informations
        @share_price_per_day = {}
        @share_informations.each do |information|
            
            @share_price_per_day[information.date] = information.share_price

        end
        @share_information = @share.share_informations.last
        
        
    end

    def render_select_shares_sector
        if params[:country_id] == "none" && params[:sector_id] == "none"
            @shares = Share.all
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