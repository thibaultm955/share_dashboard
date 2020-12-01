class ShareToPortfoliosController < ApplicationController
    def show
        @share_to_portfolio = ShareToPortfolio.find(params[:id])
    end
    
    
    def new
        @portfolio = Portfolio.find(params[:portfolio_id])
        @share_to_portfolio = ShareToPortfolio.new
        @shares = Share.all
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

    def create
        @share = Share.where(name: params_share_portfolio[:share_id])[0]
        @portfolio = Portfolio.find(params[:portfolio_id])
        @share_to_portfolio = ShareToPortfolio.new(price_objective: params_share_portfolio[:price_objective])
        @share_to_portfolio.share = @share
        @share_to_portfolio.portfolio = @portfolio
        if @share_to_portfolio.valid?
            @share_to_portfolio.save
            redirect_to portfolio_path(@portfolio)
        else
            redirect_to new_portfolio_share_to_portfolio_path(@portfolio),  notice: "Share Already in Portfolio"
        end
    end

    def edit
        @share_to_portfolio = ShareToPortfolio.find(params[:id])
        @share = Share.find(@share_to_portfolio.share_id)
        @portfolio = Portfolio.find(params[:portfolio_id])
    end

    def update
        @share_to_portfolio = ShareToPortfolio.find(params[:id])
        @share_to_portfolio.update(price_objective: params_share_portfolio[:price_objective])
        @portfolio = Portfolio.find(params[:portfolio_id])
        redirect_to portfolio_path(@portfolio)
    end

    def destroy
        @share_to_portfolio = ShareToPortfolio.find(params[:id])
        @portfolio = Portfolio.find(params[:portfolio_id])
        @share_to_portfolio.destroy
        redirect_to portfolio_path(@portfolio)
    end


    private

    def params_share_portfolio
        params.require(:share_to_portfolio).permit(:share_id, :price_objective, :portfolio_id, :price_objective)
    end
end