# frozen_string_literal: true

class FacturasController < ApplicationController
  layout :set_layout
  before_action :checkaccess

  def checkaccess
    return is_permit('facturas')
  end

  # GET /facturas/verfactura?factura_id=X
  def verfactura
    @factura = Factura.find(params[:factura_id])
  end

  # GET /facturas
  def index
    @q        = Factura.ransack(params[:q])
    @facturas = @q.result.paginate(page: params[:page], per_page: 20)
    respond_to { |format| format.html }
  end

  # GET /facturas/busqueda
  def busqueda
  end

  # GET /facturas/buscar
  def buscar
    @facturas = Factura.buscar(
      params[:buscarident].to_s,
      params[:buscarnombre].to_s,
      params[:buscarfactura].to_s,
      params[:buscarabono].to_s
    )
    if @facturas.count == 1
      redirect_to edit_factura_path(@facturas.first)
    elsif @facturas.count == 0
      flash[:notice] = 'No hay informacion de la busqueda'
      redirect_to busqueda_facturas_path
    end
  end

  # GET /facturas/informeclases
  def informeclases
    if params[:ubicacion].blank? ||
       params[:ubicacion][:inicial].blank? ||
       params[:ubicacion][:final].blank?
      flash[:notice] = 'Debe digitar datos para la consulta'
      redirect_to busqueda_facturas_path and return
    end
    response.headers['Content-Type']        = 'application/vnd.ms-excel'
    response.headers['Content-Disposition'] = "attachment; filename=\"Heroica_Clases_#{Time.now.strftime('%Y%m%d_%X')}.xls\""
    response.headers['Cache-Control']       = 'max-age=0'
    response.headers['pragma']              = 'public'
    @facturas = Factura.where(
      'DATE(created_at) BETWEEN ? AND ?',
      params[:ubicacion][:inicial].to_date,
      params[:ubicacion][:final].to_date
    ).order(:nro_factura)
  end

  # GET /facturas/:id/edit
  def edit
    @factura = Factura.find(params[:id])
  end

  # PATCH /facturas/:id
  def update
    @factura = Factura.find(params[:id])
    if @factura.update(factura_params)
      flash[:notice] = t(:notice_actualiza_msj)
      redirect_to edit_factura_path(@factura)
    else
      render :edit
    end
  end

  private

  def factura_params
    params.require(:factura).permit!
  end

  def set_layout
    if %w[informeclases].include?(action_name)
      'excel'
    else
      'application'
    end
  end
end
