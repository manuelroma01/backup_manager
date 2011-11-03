class UsersController < ApplicationController
  load_and_authorize_resource # permisos cancan

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
  
  def destroy
    @user = User.find(params[:id])
    unless @user.id == current_user.id
      @user.destroy
      flash[:success] = "Usuario #{@user.username} eliminado"
      redirect_to users_path
    else
      flash[:error] = "El usuario no puede auto-destruirse"
      @user.reload
      render 'show'
    end
  end
end
