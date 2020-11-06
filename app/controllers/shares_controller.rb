class SharesController < ApplicationController

    def new
        @portfolio = Portfolio.find(params[:portfolio_id])
        @share = Share.all
    end

    def show
        @share = Share.find(params[:id])
        @share_informations = @share.share_informations
    end
end