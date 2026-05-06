class ParqueaderosController < ApplicationController
  before_filter :require_user

  def index
    @parqueaderos = Parqueadero.all
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @parqueaderos }
    end
  end

  def buscar
    @parqueaderos      = Parqueadero.buscar(params[:ubicacion][:placa])
    if @parqueaderos.count == 1
      redirect_to edit_parqueadero_path(@parqueaderos)
    elsif @parqueaderos.count == 0
      flash[:notice] = "No hay informacion de la busqueda"
      redirect_to busqueda_parqueaderos_path
    end
  rescue
    flash[:notice] = "Debe digitar datos para la consulta"
    redirect_to busqueda_parqueaderos_path
  end

  def show
    @parqueadero = Parqueadero.find(params[:id])
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @parqueadero }
    end
  end

  def new
    @parqueadero = Parqueadero.new
    render :action => "parqueadero_form"
  end

  def edit
    @parqueadero = Parqueadero.find(params[:id])
    respond_to do |format|
      format.html { render :action => "parqueadero_form" }
    end
  end

  def create
    @parqueadero = Parqueadero.new(params[:parqueadero])
    if @parqueadero.save
      flash[:notice] = "Registro Creado con Exito."
      redirect_to edit_parqueadero_path(@parqueadero)
    else
      render :action => "parqueadero_form"
     end
  end

  def update
    @parqueadero = Parqueadero.find(params[:id])
    if @parqueadero.update_attributes(params[:parqueadero])
     flash[:notice] = "Registro Actualizado con Exito."
      redirect_to edit_parqueadero_path(@parqueadero)
    else
      @parqueaderosimagen = Parqueaderosimagen.new
      render :action => "parqueadero_form"
    end
  end

  def destroy
    @parqueadero = Parqueadero.find(params[:id])
    @parqueadero.destroy
    respond_to do |format|
      format.html { redirect_to(parqueaderos_url) }
      format.xml  { head :ok }
    end
  end
end


