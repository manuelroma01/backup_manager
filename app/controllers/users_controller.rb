class UsersController < ApplicationController
  before_filter :authenticate_user! # solo usuarios autorizados

  def index
    @users = User.paginate(:page => params[:page])
  end
  
  def show
    @user = User.find(params[:id])
  end
  
  def new
    @user = User.new
  end
  
  def create
    @user = User.new(params[:user])
    if @user.save
      flash[:success] = "Usuario #{@user.username} creado"
      redirect_to @user
    else
      render 'new'
    end
  end
  
  def edit
    @user = User.find(params[:id])
  end
  
  def update
    @user = User.find(params[:id])
    if @user.update_attributes(params[:user])
      flash[:success] = "Usuario #{@user.username} modificado"
      redirect_to @user
    else
      @user.reload
      render 'edit'
    end
  end
  
  def delete
    flash[:sucess] = "llega a delete"
  end
  
  def destroy
    @user = User.find(params[:id]).destroy
    flash[:success] = "Usuario #{@user.username} eliminado"
    redirect_to users_path
  end
end
