class ProveedoresController < ApplicationController
  before_filter :require_user

  def add_proveedor
    @proveedor = Proveedor.new(params[:proveedor])
    @proveedor.save
    @proveedores = Proveedor.find(:all, :order => 'created_at DESC')
    respond_to do |format|
      if @proveedor.save
        format.html { redirect_to proveedores_path }
        format.js
      else
        format.html { redirect_to proveedores_path }
        format.js
      end
    end
  end

  def index
    @proveedores = Proveedor.all
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @proveedores }
    end
  end

  def show
    @proveedor = Proveedor.find(params[:id])
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @proveedor }
    end
  end

  def new
    @proveedor = Proveedor.new
    render :action => "proveedor_form"
  end

  def buscar
    @proveedor = Proveedor.new
    @proveedor.nro_proveedor  = params[:buscarnroproveedor]
    @proveedor.observacion  = params[:buscarobs]
    @proveedores = Proveedor.search(@proveedor,
                             params[:ubicacion][:fchinicial],
                             params[:ubicacion][:fchfinal])
    if @proveedores.count == 0 and params[:format] != 'xls'
      flash[:notice] = "No hay resultados de la busqueda"
      redirect_to busqueda_proveedores_path
    elsif @proveedores.count == 1 and params[:format] != 'xls'
      redirect_to edit_proveedor_path(@proveedores)
    else
      respond_to do |format|
         format.html
         format.xls if params[:format] == 'xls'
      end
    end
  end

  def edit
    @proveedor = Proveedor.find(params[:id])
    respond_to do |format|
      format.html { render :action => "proveedor_form" }
    end
  end

  def create
    @proveedor = Proveedor.new(params[:proveedor])
    @proveedor.user_id = is_admin
    if @proveedor.save
      flash[:notice] = "El registro ha sido registrado con Exito."
      redirect_to edit_proveedor_path(@proveedor)
    else
      render :action => "proveedor_form"
    end
  end

  def update
    @proveedor = Proveedor.find(params[:id])
    @proveedor.user_actualiza = is_admin
    if @proveedor.update_attributes(params[:proveedor])
      flash[:notice] = "El registro ha sido actualizado con Exito."
      redirect_to edit_proveedor_path(@proveedor)
    else
      render :action => "proveedor_form"
    end
    rescue
      redirect_to edit_proveedor_path(@proveedor)
  end

  def destroy
    @proveedor = Proveedor.find(params[:id])
    @proveedor.destroy
    respond_to do |format|
      format.html { redirect_to(proveedores_url) }
      format.xml  { head :ok }
    end
  end
end
