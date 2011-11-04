class EquipmentsController < ApplicationController
  load_and_authorize_resource # permisos cancan
  before_filter :authenticate_user!   # acceso a usuarios logeados
  
  def index
    @equipments = Equipment.paginate(:page => params[:page])
  end

  def show
    @equipment = Equipment.find(params[:id])
  end

  def new
    @equipment = Equipment.new
  end

  def create
    @equipment = Equipment.new(params[:equipment])
    if @equipment.save
      redirect_to @equipment, :notice => "Successfully created equipment."
    else
      render :action => 'new'
    end
  end

  def edit
    @equipment = Equipment.find(params[:id])
  end

  def update
    @equipment = Equipment.find(params[:id])
    if @equipment.update_attributes(params[:equipment])
      flash[:success] = "Equipment actualizada"
      redirect_to @equipment
    else
      @equipment.reload
      render 'edit'
    end
  end

  def destroy
    @equipment = Equipment.find(params[:id])
    @equipment.destroy
    redirect_to equipments_url, :notice => "Successfully destroyed equipment."
  end
end
