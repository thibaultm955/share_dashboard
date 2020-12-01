class SharesController < ApplicationController
    def index
        @shares = Share.all
        respond_to do |format|
            format.html
            format.json { render json: { shares: @shares } }
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


    def render_select_shares
        @country = Country.find(params[:country_id])
        @shares = @country.shares
        html_string = render_to_string(partial: "select_shares.html.erb", locals: {shares: @shares})
        render json: {html_string: html_string}

    end
end