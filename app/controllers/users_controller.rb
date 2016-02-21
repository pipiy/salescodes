class UsersController < ApplicationController
  before_action :authenticate_user!

  def index
    @user = User.all
  end

  def edit
    @user = User.find(params[:id])

    render :json => @user
  end

  def update
    @user = User.find(params[:id])
    @user.update_attributes(params[:user])

    render :json => @user
  end

  def show
    @user = User.find(params[:id])
  end
end
