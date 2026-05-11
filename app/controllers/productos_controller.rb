class ProductosController < ApplicationController
  before_action :set_producto, only: [:show, :edit, :update, :destroy]

  layout :set_layout
  before_action :checkaccess

  def checkaccess
    return is_permit('productos')
  end

  def index
    @q = Producto.ransack(params[:q])
    @productos = @q.result.paginate(:page => params[:page], :per_page => 15)
    respond_to do |format|
      format.html
    end
  end

  def show
    respond_to { |format| format.js }
  end

  def new
    @active_record = Producto.find(params[:active_id]) if params[:active_id].present?
    @producto = Producto.new
    respond_to { |format| format.js }
  end

  def edit
    @active_record = Producto.find(params[:active_id]) if params[:active_id].present?
    respond_to { |format| format.js }
  end

  def create
    @producto = Producto.new(producto_params)
    @producto.user_id = is_admin
    respond_to do |format|
      if @producto.save
        flash[:notice] = t(:notice_crea_msj)
        format.js
      else
        format.js { render 'layouts/errors', locals: { object: @producto } }
      end
    end
  end

  def update
    @producto.user_actualiza = is_admin
    respond_to do |format|
      if @producto.update(producto_params)
        flash[:notice] = t(:notice_actualiza_msj)
        format.js
      else
        format.js { render 'layouts/errors', locals: { object: @producto } }
      end
    end
  end

  def destroy
    @producto.destroy
    flash['success'] = 'Eliminado con éxito'
    respond_to { |format| format.js }
  end

  private

    def set_producto
      @producto = Producto.find(params[:id])
    end

    def producto_params
      params.require(:producto).permit!
    end

    def set_layout
      'application_admin'
    end
end
