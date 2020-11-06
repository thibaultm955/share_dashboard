class ShareInformationsController < ApplicationController

    def show
        @share = Share.find(params[:id])
        @share_information = @share.share_informations
        
    end
end