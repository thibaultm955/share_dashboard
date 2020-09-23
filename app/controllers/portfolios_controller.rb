class PortfoliosController < ApplicationController
    def index
        @user = current_user
        @portfolios = @user.portfolios
    end

    def show
        @portfolio = Portfolio.find(params[:id])
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