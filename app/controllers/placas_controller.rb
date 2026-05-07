class PlacasController < ApplicationController
  before_action :set_placa, only: [:show, :edit, :update, :destroy]

  layout :set_layout
  before_action :checkaccess

  def checkaccess
    return is_permit('placas')
  end

  def index
    @q = Placa.ransack(params[:q])
    @placas = @q.result.paginate(:page => params[:page], :per_page => 15)
    respond_to do |format|
      format.html
    end
  end

  def show
    respond_to { |format| format.js }
  end

  def new
    @active_record = Placa.find(params[:active_id]) if params[:active_id].present?
    @placa = Placa.new
    respond_to { |format| format.js }
  end

  def edit
    @active_record = Placa.find(params[:active_id]) if params[:active_id].present?
    respond_to { |format| format.js }
  end

  def create
    @placa = Placa.new(placa_params)
    respond_to do |format|
      if @placa.save
        flash[:notice] = t(:notice_crea_msj)
        format.js
      else
        format.js { render 'layouts/errors', locals: { object: @placa } }
      end
    end
  end

  def update
    respond_to do |format|
      if @placa.update(placa_params)
        flash[:notice] = t(:notice_actualiza_msj)
        format.js
      else
        format.js { render 'layouts/errors', locals: { object: @placa } }
      end
    end
  end

  def destroy
    @placa.destroy
    flash['success'] = 'Eliminado con éxito'
    respond_to { |format| format.js }
  end

  private

    def set_placa
      @placa = Placa.find(params[:id])
    end

    def placa_params
      params.require(:placa).permit!
    end

    def set_layout
      if ['index'].include?(action_name)
        'application_admin'
      else
        'application_admin'
      end
    end
end
