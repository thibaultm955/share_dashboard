class ShareToPortfoliosController < ApplicationController
    def show
        @share_to_portfolio = ShareToPortfolio.find(params[:id])
    end
    
    
    def new
        # if you add a share from a portfolio
        if params[:portfolio_id].present?
            @portfolio = Portfolio.find(params[:portfolio_id])
            @share_to_portfolio = ShareToPortfolio.new
            @shares = Share.order("name asc").all
            @countries_all = Country.order("name asc").all
            @sectors_all = Sector.order("name asc").all
           
        else
            @porfolios = Portfolio.where(user_id: current_user.id)
            @share = Share.find(params[:share_id])
            @share_to_portfolio = ShareToPortfolio.new
        end
    end

    def create
        if params[:shares].present?
            @share = Share.find(params_share[:share_id])
            @portfolio = Portfolio.find(params_portfolio[:portfolio_id])
            @share_to_portfolio = ShareToPortfolio.new(price_objective: params_share_portfolio[:price_objective])
            @share_to_portfolio.share = @share
            @share_to_portfolio.portfolio = @portfolio
            if @share_to_portfolio.valid?
                @share_to_portfolio.save
                redirect_to portfolio_path(@portfolio)
            else
                redirect_to new_portfolio_share_to_portfolio_path(@portfolio),  notice: "Share Already in Portfolio"
            end
        else
           
            @share = Share.find(params[:share_id])
            @portfolio = Portfolio.find(params_portfolio[:portfolio_id])
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

    def params_share
        params.require(:shares).permit(:share_id)
    end
    
    def params_portfolio
        params.permit(:portfolio_id)
    end
end