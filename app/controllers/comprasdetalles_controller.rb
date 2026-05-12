class ComprasdetallesController < ApplicationController
  before_action :set_compra

  layout :set_layout
  before_action :checkaccess

  def checkaccess
    return is_permit('compras')
  end

  def index
    @comprasdetalles = @compra.comprasdetalles.all
  end

  def show
    @comprasdetalle = Comprasdetalle.find(params[:id])
    respond_to do |format|
      format.js
    end
  end

  def new
    @comprasdetalle = Comprasdetalle.new
    respond_to do |format|
      format.js
    end
  end

  def edit
    @comprasdetalle = Comprasdetalle.find(params[:id])
    respond_to do |format|
      format.js
    end
  end

  def create
    @comprasdetalle = Comprasdetalle.new(comprasdetalle_params)
    @comprasdetalle.user_id  = is_admin
    @comprasdetalle.compra_id = @compra.id
    if @comprasdetalle.valid?
      @comprasdetalle.valor_total = ((@comprasdetalle.valor_unitario.to_i - @comprasdetalle.valor_descuento.to_i) * @comprasdetalle.cantidad.to_i).to_i
      if @comprasdetalle.save
        @comprasdetalle_saved = @comprasdetalle
        @comprasdetalle = Comprasdetalle.new
        flash[:notice] = t(:notice_crea_msj)
      end
    end
    respond_to do |format|
      format.js
    end
  end

  def update
    @comprasdetalle = Comprasdetalle.find(params[:id])
    comprasdetalle_actualiza = comprasdetalle_params
    comprasdetalle_actualiza[:valor_total] = ((comprasdetalle_actualiza[:valor_unitario].to_i - comprasdetalle_actualiza[:valor_descuento].to_i) * comprasdetalle_actualiza[:cantidad].to_i).to_i
    @comprasdetalle.user_actualiza = is_admin
    ok = @comprasdetalle.update(comprasdetalle_actualiza)
    flash[:notice] = ok ? t(:notice_actualiza_msj) : 'Se produjo un error al actualizar'
    respond_to do |format|
      format.js
    end
  end

  def destroy
    @comprasdetalle = Comprasdetalle.find(params[:id])
    @comprasdetalle.destroy
    respond_to do |format|
      format.js
    end
  end

  private

  def set_compra
    @compra = Compra.find(params[:compra_id])
  end

  def comprasdetalle_params
    params.require(:comprasdetalle).permit!
  end

  def set_layout
    'application_admin'
  end
end
