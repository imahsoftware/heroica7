class MantenimientosController < ApplicationController

  before_filter :require_user

  def index
    @mantenimientos = Mantenimiento.all
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @mantenimientos }
    end
  end

  def buscar
    @mantenimientos      = Mantenimiento.buscar(params[:ubicacion][:placa])
    if @mantenimientos.count == 1
      redirect_to edit_mantenimiento_path(@mantenimientos)
    elsif @mantenimientos.count == 0
      flash[:notice] = "No hay informacion de la busqueda"
      redirect_to busqueda_mantenimientos_path
    end
  rescue
    flash[:notice] = "Debe digitar datos para la consulta"
    redirect_to busqueda_mantenimientos_path
  end

  def show
    @mantenimiento = Mantenimiento.find(params[:id])
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @mantenimiento }
    end
  end

  def new
    @mantenimiento = Mantenimiento.new
    render :action => "mantenimiento_form"
  end

  def edit
    @mantenimiento = Mantenimiento.find(params[:id])
    respond_to do |format|
      format.html { render :action => "mantenimiento_form" }
    end
  end

  def create
    @mantenimiento = Mantenimiento.new(params[:mantenimiento])
    if @mantenimiento.save
      flash[:notice] = "Registro Creado con Exito."
      redirect_to edit_mantenimiento_path(@mantenimiento)
    else
      render :action => "mantenimiento_form"
     end
  end

  def update
    @mantenimiento = Mantenimiento.find(params[:id])
    if @mantenimiento.update_attributes(params[:mantenimiento])
     flash[:notice] = "Registro Actualizado con Exito."
      redirect_to edit_mantenimiento_path(@mantenimiento)
    else
      @mantenimientosimagen = Mantenimientosimagen.new
      render :action => "mantenimiento_form"
    end
  end

  def destroy
    @mantenimiento = Mantenimiento.find(params[:id])
    @mantenimiento.destroy
    respond_to do |format|
      format.html { redirect_to(mantenimientos_url) }
      format.xml  { head :ok }
    end
  end
end
