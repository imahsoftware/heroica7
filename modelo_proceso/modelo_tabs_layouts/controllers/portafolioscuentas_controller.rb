class PortafolioscuentasController < ApplicationController
  before_action :set_portafolioscuenta, only: [:show, :destroy]

  def index
    @portafolioscuentas = Portafolioscuenta.all
  end

  def show
    respond_to { |format| format.js }
  end

  def detalle
    @portafolioscuenta = Portafolioscuenta.find(params[:id])
  end

  def new
    @active_record = Portafolioscuenta.find(params[:active_id]) if params[:active_id].present?
    @portafolio = Portafolio.find(params[:portafolio_id])
    @portafolioscuenta = Portafolioscuenta.new
    respond_to { |format| format.js }
  end

  def edit
    @active_record = Portafolioscuenta.find(params[:active_id]) if params[:active_id].present?
    @portafolioscuenta = Portafolioscuenta.find(params[:id])
    @portafolio = @portafolioscuenta.portafolio
    respond_to { |format| format.js }
  end

  def create
    @portafolio  = Portafolio.find(params[:portafolio_id])
    @portafolioscuenta = Portafolioscuenta.new(portafolioscuenta_params)
    @portafolioscuenta.portafolio_id = @portafolio.id
    @portafolioscuenta.user_id = is_admin
    respond_to do |format|
      if @portafolioscuenta.save
        flash[:notice] = "#{t :notice_crea_msj}"
        format.js
      else
        format.js { render 'layouts/errors', locals: { object: @portafolioscuenta } }
      end
    end
  end

  def update
    @portafolioscuenta = Portafolioscuenta.find(params[:id])
    @portafolioscuenta.user_act = is_admin
    @portafolio = @portafolioscuenta.portafolio
    respond_to do |format|
      if @portafolioscuenta.update(portafolioscuenta_params)
        flash[:notice] = "#{t :notice_actualiza_msj}"
        format.js
      else
        format.js { render 'layouts/errors', locals: { object: @portafolioscuenta } }
      end
    end
  end

  def destroy
    flash['success'] = 'Eliminado correctamente'
    @portafolioscuenta.destroy
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_portafolioscuenta
    @portafolio = Portafolio.find(params[:portafolio_id])
    @portafolioscuenta = Portafolioscuenta.find(params[:id]) if params[:id]
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def portafolioscuenta_params
    params.require(:portafolioscuenta).permit!
  end
end
