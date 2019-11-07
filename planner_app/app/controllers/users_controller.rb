class UsersController < ApplicationController

    def show
        @user = User.find_by(params[:id])
        render :show
    end

    def create
        
    end

    def new
        render :new
    end


end