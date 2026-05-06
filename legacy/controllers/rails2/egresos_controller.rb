class EgresosController < ApplicationController
  
  before_filter :require_user

  def add_egreso
    @egreso = Egreso.new(params[:egreso])
    @egreso.save
    @egresos = Egreso.find(:all, :order => 'created_at DESC')
    respond_to do |format|
      if @egreso.save
        format.html { redirect_to egresos_path }
        format.js
      else
        format.html { redirect_to egresos_path }
        format.js
      end
    end
  end

  def index
    @egresos = Egreso.all
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @egresos }
    end
  end

  def show
    @egreso = Egreso.find(params[:id])
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @egreso }
    end
  end

  def new
    @egreso = Egreso.new
    render :action => "egreso_form"
  end

  def buscar
    @egreso = Egreso.new
    @egreso.nro_egreso  = params[:buscarnroegreso]
    @egreso.observacion  = params[:buscarobs]
    @egreso.proveedor_id  = params[:ubicacion][:proveedor_id]
    @egresos = Egreso.search(@egreso,
                             params[:ubicacion][:fchinicial],
                             params[:ubicacion][:fchfinal])
    if @egresos.count == 0 and params[:format] != 'xls'
      flash[:notice] = "No hay resultados de la busqueda"
      redirect_to busqueda_egresos_path
    elsif @egresos.count == 1 and params[:format] != 'xls'
      redirect_to edit_egreso_path(@egresos)
    else
      respond_to do |format|
         format.html
         format.xls if params[:format] == 'xls'
      end
    end
  end

  def edit
    @egreso = Egreso.find(params[:id])
    @egresosimagen = Egresosimagen.new
    respond_to do |format|
      format.html { render :action => "egreso_form" }
    end
  end

  def create
    @egreso = Egreso.new(params[:egreso])
    @egreso.user_id = is_admin
    if @egreso.save
      flash[:notice] = "El registro ha sido registrado con Exito."
      redirect_to edit_egreso_path(@egreso)
    else
      render :action => "egreso_form"
    end
  end

  def update
    @egreso = Egreso.find(params[:id])
    @egreso.user_actualiza = is_admin
    if @egreso.update_attributes(params[:egreso])
      flash[:notice] = "El registro ha sido actualizado con Exito."
      redirect_to edit_egreso_path(@egreso)
    else
      render :action => "egreso_form"
    end
    rescue
      redirect_to edit_egreso_path(@egreso)
  end

  def destroy
    @egreso = Egreso.find(params[:id])
    @egreso.destroy
    respond_to do |format|
      format.html { redirect_to(egresos_url) }
      format.xml  { head :ok }
    end
  end
end
