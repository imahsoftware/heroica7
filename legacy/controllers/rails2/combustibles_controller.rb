class CombustiblesController < ApplicationController
  before_filter :require_user

  def index
    @combustibles = Combustible.all
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @combustibles }
    end
  end

  def buscar
    @combustibles      = Combustible.buscar(params[:ubicacion][:placa])
    if @combustibles.count == 1
      redirect_to edit_combustible_path(@combustibles)
    elsif @combustibles.count == 0
      flash[:notice] = "No hay informacion de la busqueda"
      redirect_to busqueda_combustibles_path
    end
  rescue
    flash[:notice] = "Debe digitar datos para la consulta"
    redirect_to busqueda_combustibles_path
  end

  def show
    @combustible = Combustible.find(params[:id])
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @combustible }
    end
  end

  def new
    @combustible = Combustible.new
    render :action => "combustible_form"
  end

  def edit
    @combustible = Combustible.find(params[:id])
    respond_to do |format|
      format.html { render :action => "combustible_form" }
    end
  end

  def create
    @combustible = Combustible.new(params[:combustible])
    if @combustible.save
      flash[:notice] = "Registro Creado con Exito."
      redirect_to edit_combustible_path(@combustible)
    else
      render :action => "combustible_form"
     end
  end

  def update
    @combustible = Combustible.find(params[:id])
    if @combustible.update_attributes(params[:combustible])
     flash[:notice] = "Registro Actualizado con Exito."
      redirect_to edit_combustible_path(@combustible)
    else
      @combustiblesimagen = Combustiblesimagen.new
      render :action => "combustible_form"
    end
  end

  def destroy
    @combustible = Combustible.find(params[:id])
    @combustible.destroy
    respond_to do |format|
      format.html { redirect_to(combustibles_url) }
      format.xml  { head :ok }
    end
  end
end
