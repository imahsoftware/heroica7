class ProveedoresController < ApplicationController
  before_action :set_proveedor, only: [:show, :edit, :update, :destroy]

  layout :set_layout
  before_action :checkaccess

  def checkaccess
    return is_permit('proveedores')
  end

  def index
    @q = Proveedor.ransack(params[:q])
    @proveedores = @q.result.paginate(page: params[:page], per_page: 15)
    respond_to do |format|
      format.html
    end
  end

  def show
    respond_to { |format| format.js }
  end

  def new
    @active_record = Proveedor.find(params[:active_id]) if params[:active_id].present?
    @proveedor = Proveedor.new
    respond_to { |format| format.js }
  end

  def edit
    @active_record = Proveedor.find(params[:active_id]) if params[:active_id].present?
    respond_to { |format| format.js }
  end

  def create
    @proveedor = Proveedor.new(proveedor_params)
    @proveedor.user_id = is_admin
    respond_to do |format|
      if @proveedor.save
        flash[:notice] = t(:notice_crea_msj)
        format.js
      else
        format.js { render 'layouts/errors', locals: { object: @proveedor } }
      end
    end
  end

  def update
    @proveedor.user_actualiza = is_admin
    respond_to do |format|
      if @proveedor.update(proveedor_params)
        flash[:notice] = t(:notice_actualiza_msj)
        format.js
      else
        format.js { render 'layouts/errors', locals: { object: @proveedor } }
      end
    end
  end

  def destroy
    @proveedor.destroy
    flash['success'] = 'Eliminado con éxito'
    respond_to { |format| format.js }
  end

  private

  def set_proveedor
    @proveedor = Proveedor.find(params[:id])
  end

  def proveedor_params
    params.require(:proveedor).permit(
      :documento, :identificacion,
      :primer_nombre, :segundo_nombre, :primer_apellido, :segundo_apellido,
      :razon_social, :contacto, :direccion, :departamento, :ciudad,
      :telefonos, :celular, :fax, :email,
      :productos, :especificaciones
    )
  end

  def set_layout
    'application_admin'
  end
end
