class EmpleadosController < ApplicationController
  before_filter :require_user
  layout :determine_layout

  def index
    @empleados = Empleado.all
  end

  def new
    @empleado = Empleado.new
    render :action => "empleado_form"
  end

  def edit
    @empleado = Empleado.find(params[:id])
    respond_to do |format|
      format.html { render :action => "empleado_form" }
    end
  end

  def create
    @empleado = Empleado.new(params[:empleado])
    if @empleado.save
      flash[:notice] = "Usuario Creado con Exito."
      redirect_to edit_empleado_path(@empleado)
    else
      render :action => "empleado_form"
     end
  end

  def update
    @empleado = Empleado.find(params[:id])
    if @empleado.update_attributes(params[:empleado])
     flash[:notice] = "Usuario Actualizado con Exito."
      redirect_to edit_empleado_path(@empleado)
    else
      render :action => "empleado_form"
    end
    rescue
      redirect_to edit_empleado_path(@empleado)
  end

  def destroy
    @empleado = Empleado.find(params[:id])
    @empleado.destroy
    respond_to do |format|
      format.html { redirect_to(empleados_url) }
      format.xml  { head :ok }
    end
  end

  private
  def determine_layout
    if ['new2','create2','show','edit2','update2','informeempleado','verinfo'].include?(action_name)
      "new2"
    elsif ['informeempleado'].include?(action_name)
      "tirilla"
    else
      "application"
    end
  end
end
