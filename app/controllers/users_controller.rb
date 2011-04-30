class UsersController < ApplicationController
  before_filter :authenticate_user! # solo usuarios autorizados

  def index
    @users = User.all
  end
  
  def show
    @user = User.find(params[:id])
  end
  
  def new
    @user = User.new
  end
  
end
