# frozen_string_literal: true

class DetallesfacturasController < ApplicationController
  layout 'application'
  #before_action :checkaccess
  before_action :set_factura
  before_action :set_detallesfactura, only: [:edit, :update, :destroy]

  def checkaccess
    return is_permit('detallesfacturas')
  end

  def edit
    respond_to do |format|
      format.js
      format.html { redirect_to edit_factura_path(@factura) }
    end
  end

  def create
    @detallesfactura = Detallesfactura.new(detallesfactura_params)
    @detallesfactura.categoria_id    = @factura.categoria_id
    @detallesfactura.tipostramite_id = @factura.tipostramite_id
    @detallesfactura.user_id         = is_admin

    if @detallesfactura.valid?
      @factura.detallesfacturas << @detallesfactura
      @detallesfactura = Detallesfactura.new
      flash.now[:detallesfactura] = 'Creado con exito'
    else
      flash.now[:detallesfactura] = 'Se produjo un error al guardar el registro'
    end

    respond_to do |format|
      format.js { render 'detallesfacturas' }
      format.html { redirect_to edit_factura_path(@factura) }
    end
  end

  def update
    @detallesfactura.user_actualiza = is_admin

    if @detallesfactura.update(detallesfactura_params)
      @detallesfactura = Detallesfactura.new
      flash.now[:detallesfactura] = 'Actualizado con Exito'
    else
      flash.now[:detallesfactura] = 'El registro tiene inconsistencias. Verifique!!'
    end

    respond_to do |format|
      format.js { render 'detallesfacturas' }
      format.html { redirect_to edit_factura_path(@factura) }
    end
  end

  def destroy
    @detallesfactura.destroy
    ActiveRecord::Base.connection.execute(
      "UPDATE facturas SET valor = (SELECT COALESCE(SUM(valor),0) FROM detallesfacturas WHERE factura_id = #{@factura.id}) WHERE id = #{@factura.id}"
    )
    @detallesfactura = Detallesfactura.new
    flash.now[:detallesfactura] = 'Borrado con exito'

    respond_to do |format|
      format.js { render 'detallesfacturas' }
      format.html { redirect_to edit_factura_path(@factura) }
    end
  end

  private

  def set_factura
    @factura = Factura.find(params[:factura_id])
  end

  def set_detallesfactura
    @detallesfactura = Detallesfactura.find(params[:id])
  end

  def detallesfactura_params
    params.require(:detallesfactura).permit(:concepto_id, :cantidad, :valor)
  end
end
