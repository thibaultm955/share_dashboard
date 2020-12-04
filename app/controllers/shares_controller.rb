class SharesController < ApplicationController
    def index
        if params[:query].present?
            @shares_index = Share.where("name ILIKE ?", "%#{params[:query]}%")[0..99]
          else
            @shares = Share.all
            respond_to do |format|
                format.html
                format.json { render json: { shares: @shares } }
            end
            @shares_index = @shares[0..99]
          end
          
        
    end


    def new
        @portfolio = Portfolio.find(params[:portfolio_id])
        @share = Share.all
    end

    def show
        @share = Share.find(params[:id])
        @share_informations = @share.share_informations
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