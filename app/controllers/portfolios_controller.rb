class PortfoliosController < ApplicationController
    def index
        @user = current_user
        @portfolios = @user.portfolios

    end

    def show
        @portfolio = Portfolio.find(params[:id])
        @share_to_portfolio = ShareToPortfolio.where(portfolio_id: @portfolio.id)
        @shares = []
        time = Time.new
        time = time.strftime("%Y-%m-%d")
        @share_to_portfolio.each do |share_portfolio|
            share = Share.find(share_portfolio.share_id)
            # We want to extract the latest Share Information available in the DB
            @shares << [share.name, ShareInformation.where(share_id: share_portfolio.share_id)[-1], share_portfolio.id, share_portfolio.price_objective, share.id, !share_portfolio.comment.nil? ? share_portfolio.comment : ""]
            
        end
        @shares = @shares.sort
        
    end

    def new
        @portfolio = Portfolio.new
    end

    def create
        @portfolio = Portfolio.new(name: params_portfolio[:name])
        @user = current_user
        @portfolio.user = @user
        if @portfolio.save
            redirect_to portfolios_path
        else
            render :new
        end
    end

    def edit
        @portfolio = Portfolio.find(params[:id])
    end

    def update
        @portfolio = Portfolio.find(params[:id])
        @portfolio = @portfolio.update(name: params_portfolio[:name])
        @portfolio = Portfolio.find(params[:id])
        redirect_to portfolio_path(@portfolio)
    end

    def destroy
        @portfolio = Portfolio.find(params[:id])
        @portfolio.destroy
        redirect_to portfolios_path
    end

    private

    def params_portfolio
        params.require(:portfolio).permit(:name)
    end
end