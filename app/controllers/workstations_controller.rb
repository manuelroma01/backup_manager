class WorkstationsController < ApplicationController
  before_filter :authenticate_user!   # acceso a usuarios logeados
  
  def index
    @workstations = Workstation.paginate(:page => params[:page])
  end

  def show
    @workstation = Workstation.find(params[:id])
  end

  def new
    @workstation = Workstation.new
  end

  def create
    @workstation = Workstation.new(params[:workstation])
    if @workstation.save
      redirect_to @workstation, :notice => "Successfully created workstation."
    else
      render :action => 'new'
    end
  end

  def edit
    @workstation = Workstation.find(params[:id])
  end

  def update
    @workstation = Workstation.find(params[:id])
    if @workstation.update_attributes(params[:workstation])
      redirect_to @workstation, :notice  => "Successfully updated workstation."
    else
      render :action => 'edit'
    end
  end

  def destroy
    @workstation = Workstation.find(params[:id])
    @workstation.destroy
    redirect_to workstations_url, :notice => "Successfully destroyed workstation."
  end
end
