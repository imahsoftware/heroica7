class DetallesfacturasController < ApplicationController
  before_filter :require_user
  layout :determine_layout

  def index
    factura   = Factura.find(params[:factura_id])
    @detallesfacturas = factura.detallesfacturas.all
  end

 def edit
    @detallesfactura  = Detallesfactura.find(params[:id], :include => "factura")
    @factura  = @detallesfactura.factura
    respond_to do |format|
      format.js { render :action => "edit_detallesfactura" }
    end
  end

  def create
    @factura  = Factura.find(params[:factura_id])
    @detallesfactura = Detallesfactura.new(params[:detallesfactura])
    @detallesfactura.categoria_id = @factura.categoria_id
    @detallesfactura.tipostramite_id = @factura.tipostramite_id
    @detallesfactura.user_id = is_admin
    if @detallesfactura.valid?
      @factura.detallesfacturas << @detallesfactura
      @factura.save
      @detallesfactura = Detallesfactura.new
      flash[:detallesfactura] = "Creado con exito"
    else
      flash[:detallesfactura] = "Se produjo un error al guardar el registro"
    end
    respond_to do |format|
      format.js { render :action => "detallesfacturas" }
    end
  end

  def update
    @detallesfactura        = Detallesfactura.new
    detallesfactura         = Detallesfactura.find(params[:id])
    detallesfactura.user_actualiza = is_admin
    @factura        = detallesfactura.factura
    ok = detallesfactura.update_attributes(params[:detallesfactura])
    if ok == true
      flash[:detallesfactura] = "Actualizado con Exito"
      respond_to do |format|
        format.js { render :action => "detallesfacturas" }
      end
    else
      render :update do |page|
         page.alert "El registro tiene inconsistencias. Verifique!!"
      end
    end
  end

  def destroy
    detallesfactura   = Detallesfactura.find(params[:id])
    @factura  = detallesfactura.factura
    @detallesfactura  = Detallesfactura.new
#    detallesfactura.respaldo(is_admin)
    detallesfactura.destroy
    ActiveRecord::Base.connection.execute("update facturas set valor = (select sum(valor) from detallesfacturas where factura_id = facturas.id) where id = #{@factura.id}")
    flash[:detallesfactura] = "Borrado con exito"
    respond_to do |format|
      format.js { render :action => "detallesfacturas" }
    end
  end

  private
  def determine_layout
    if ['crearfactura'].include?(action_name)
      "basico"
    else
      "application"
    end
  end
end
