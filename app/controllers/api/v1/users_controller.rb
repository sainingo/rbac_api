class Api::V1::UsersController < ApplicationController
    before_action :set_user, only: [:show, :update, :destroy]
    before_action -> { authorize_request('manage_users') }, except: [:show]
  
    def index
      @users = User.page(params[:page]).per(params[:per_page])
      render json: @users, status: :ok
    end
  
    def show
      render json: @user, status: :ok
    end
  
    def create
      @user = User.new(user_params)
      @user.save!
      render json: @user, status: :created
    end
  
    def update
      @user.update!(user_params)
      render json: @user, status: :ok
    end
  
    def destroy
      @user.destroy
      head :no_content
    end
  
    private
  
    def set_user
      @user = User.find(params[:id])
    end
  
    def user_params
      params.require(:user).permit(:email, :password, :role_id)
    end
  end
