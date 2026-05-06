class ComprasdetallesController < ApplicationController

  before_filter :require_user

  def index
    compra   = Compra.find(params[:compra_id])
    @comprasdetalles = compra.comprasdetalles.all
  end

  def edit
    @comprasdetalle  = Comprasdetalle.find(params[:id], :include => "compra")
    @compra  = @comprasdetalle.compra
    respond_to do |format|
      format.js { render :action => "edit_comprasdetalle" }
    end
  end

  def create
    @compra  = Compra.find(params[:compra_id])
    @comprasdetalle = Comprasdetalle.new(params[:comprasdetalle])
    @comprasdetalle.user_id = is_admin
    if @comprasdetalle.valid?
      @comprasdetalle.valor_total = ((@comprasdetalle.valor_unitario.to_i - @comprasdetalle.valor_descuento.to_i) * @comprasdetalle.cantidad.to_i).to_i
      @compra.comprasdetalles << @comprasdetalle
      @compra.save
      @comprasdetalle = Comprasdetalle.new
    else
      flash[:warning] = "Se produjo un error al guardar el registro"
    end
    respond_to do |format|
      format.js { render :action => "comprasdetalles" }
    end
  end

  def update
    @comprasdetalle        = Comprasdetalle.new
    comprasdetalle         = Comprasdetalle.find(params[:id])
    params[:comprasdetalle][:valor_total] = ((params[:comprasdetalle][:valor_unitario].to_i - params[:comprasdetalle][:valor_descuento].to_i) * params[:comprasdetalle][:cantidad].to_i).to_i
    comprasdetalle.user_actualiza = is_admin
    @compra        = comprasdetalle.compra
    ok = comprasdetalle.update_attributes(params[:comprasdetalle])
    flash[:notice] = ok ? "Usuario asociado Correctamente." : "Se produjo un error al Asociar"
    respond_to do |format|
      format.js { render :action => "comprasdetalles" }
    end
  end

  def destroy
    comprasdetalle   = Comprasdetalle.find(params[:id])
    @compra  = comprasdetalle.compra
    @comprasdetalle  = Comprasdetalle.new
    comprasdetalle.destroy
    respond_to do |format|
      format.js { render :action => "comprasdetalles" }
    end
  end
end
