class ProductosController < ApplicationController
  before_filter :require_user

  def add_producto
    @producto = Producto.new(params[:producto])
    @producto.save
    @productos = Producto.find(:all, :order => 'created_at DESC')
    respond_to do |format|
      if @producto.save
        format.html { redirect_to productos_path }
        format.js
      else
        format.html { redirect_to productos_path }
        format.js
      end
    end
  end

  def index
    @productos = Producto.all
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @productos }
    end
  end

  def show
    @producto = Producto.find(params[:id])
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @producto }
    end
  end

  def new
    @producto = Producto.new
    render :action => "producto_form"
  end

  def buscar
    @producto = Producto.new
    @producto.nro_producto  = params[:buscarnroproducto]
    @producto.observacion  = params[:buscarobs]
    @productos = Producto.search(@producto,
                             params[:ubicacion][:fchinicial],
                             params[:ubicacion][:fchfinal])
    if @productos.count == 0 and params[:format] != 'xls'
      flash[:notice] = "No hay resultados de la busqueda"
      redirect_to busqueda_productos_path
    elsif @productos.count == 1 and params[:format] != 'xls'
      redirect_to edit_producto_path(@productos)
    else
      respond_to do |format|
         format.html
         format.xls if params[:format] == 'xls'
      end
    end
  end

  def edit
    @producto = Producto.find(params[:id])
    respond_to do |format|
      format.html { render :action => "producto_form" }
    end
  end

  def create
    @producto = Producto.new(params[:producto])
    @producto.user_id = is_admin
    if @producto.save
      flash[:notice] = "El registro ha sido registrado con Exito."
      redirect_to edit_producto_path(@producto)
    else
      render :action => "producto_form"
    end
  end

  def update
    @producto = Producto.find(params[:id])
    @producto.user_actualiza = is_admin
    if @producto.update_attributes(params[:producto])
      flash[:notice] = "El registro ha sido actualizado con Exito."
      redirect_to edit_producto_path(@producto)
    else
      render :action => "producto_form"
    end
    rescue
      redirect_to edit_producto_path(@producto)
  end

  def destroy
    @producto = Producto.find(params[:id])
    @producto.destroy
    respond_to do |format|
      format.html { redirect_to(productos_url) }
      format.xml  { head :ok }
    end
  end
end
