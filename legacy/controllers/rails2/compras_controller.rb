class ComprasController < ApplicationController
  before_filter :require_user

  def add_compra
    @compra = Compra.new(params[:compra])
    @compra.save
    @compras = Compra.find(:all, :order => 'created_at DESC')
    respond_to do |format|
      if @compra.save
        format.html { redirect_to compras_path }
        format.js
      else
        format.html { redirect_to compras_path }
        format.js
      end
    end
  end

  def index
    @compras = Compra.all
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @compras }
    end
  end

  def show
    @compra = Compra.find(params[:id])
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @compra }
    end
  end

  def new
    @compra = Compra.new
    render :action => "compra_form"
  end

  def edit
    @compra = Compra.find(params[:id])
    @comprasdetalle = Comprasdetalle.new
    respond_to do |format|
      format.html { render :action => "compra_form" }
    end
  end

  def create
    @compra = Compra.new(params[:compra])
    @compra.user_id = is_admin
    if @compra.save
      flash[:notice] = "El registro ha sido registrado con Exito."
      redirect_to edit_compra_path(@compra)
    else
      @comprasdetalle = Comprasdetalle.new
      render :action => "compra_form"
    end
  end

  def update
    @compra = Compra.find(params[:id])
    @compra.user_actualiza = is_admin
    if @compra.update_attributes(params[:compra])
      flash[:notice] = "El registro ha sido actualizado con Exito."
      redirect_to edit_compra_path(@compra)
    else
      @comprasdetalle = Comprasdetalle.new
      render :action => "compra_form"
    end
    rescue
      redirect_to edit_compra_path(@compra)
  end

  def destroy
    @compra = Compra.find(params[:id])
    @compra.destroy
    respond_to do |format|
      format.html { redirect_to(compras_url) }
      format.xml  { head :ok }
    end
  end
end
