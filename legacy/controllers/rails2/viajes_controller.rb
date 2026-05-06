class ViajesController < ApplicationController
  before_filter :require_user

  def index
    @viajes = Viaje.all
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @viajes }
    end
  end

  def buscar
    @viajes      = Viaje.buscar(params[:ubicacion][:tour], params[:identificacion])
    if @viajes.count == 1
      redirect_to edit_viaje_path(@viajes)
    elsif @viajes.count == 0
      flash[:notice] = "No hay informacion de la busqueda"
      redirect_to busqueda_viajes_path
    end
  rescue
    flash[:notice] = "Debe digitar datos para la consulta"
    redirect_to busqueda_viajes_path
  end

  def informe
    headers['Content-Type'] = "application/vnd.ms-excel"
    headers['Content-Disposition'] = 'attachment; filename="informe_'+"#{Time.now.strftime("%Y_%m_%d_%X")}"+'.xls"'
    headers['Cache-Control'] = ''
    @viajesrecibos = Viajesrecibo.find(:all)
    respond_to do |format|
       format.xls
    end
  end

  def show
    @viaje = Viaje.find(params[:id])
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @viaje }
    end
  end

  def new
    @viaje = Viaje.new
    render :action => "viaje_form"
  end

  def edit
    @viaje = Viaje.find(params[:id])
    respond_to do |format|
      format.html { render :action => "viaje_form" }
    end
  end

  def create
    @viaje = Viaje.new(params[:viaje])
    if @viaje.save
      flash[:notice] = "Registro Creado con Exito."
      redirect_to edit_viaje_path(@viaje)
    else
      render :action => "viaje_form"
     end
  end

  def update
    @viaje = Viaje.find(params[:id])
    if @viaje.update_attributes(params[:viaje])
     flash[:notice] = "Registro Actualizado con Exito."
      redirect_to edit_viaje_path(@viaje)
    else
      render :action => "viaje_form"
    end
  end

  def destroy
    @viaje = Viaje.find(params[:id])
    @viaje.destroy
    respond_to do |format|
      format.html { redirect_to(viajes_url) }
      format.xml  { head :ok }
    end
  end
end
