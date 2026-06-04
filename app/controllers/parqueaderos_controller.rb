# frozen_string_literal: true

class ParqueaderosController < ApplicationController
  before_action :set_parqueadero, only: [:show, :edit, :update, :destroy]

  layout :set_layout
  before_action :checkaccess

  def checkaccess
    is_permit('parqueaderos') || is_permit('parqueadero')
  end

  def index
    @placas = Placa.order(:descripcion)
    @q = Parqueadero.includes(:placa, :instructor).ransack(params[:q])
    @q.sorts = 'fecha_hora desc' if @q.sorts.empty?
    @parqueaderos = @q.result.paginate(page: params[:page], per_page: 15)
    respond_to { |format| format.html }
  end

  def show
    respond_to { |format| format.js }
  end

  def new
    @active_record = Parqueadero.find(params[:active_id]) if params[:active_id].present?
    @parqueadero   = Parqueadero.new
    @parqueadero.placa_id = params[:placa_id] if params[:placa_id].present?
    respond_to { |format| format.js }
  end

  def edit
    @active_record = Parqueadero.find(params[:active_id]) if params[:active_id].present?
    respond_to { |format| format.js }
  end

  def create
    @parqueadero = Parqueadero.new(parqueadero_params)
    respond_to do |format|
      if @parqueadero.save
        flash[:notice] = t(:notice_crea_msj)
        format.js
      else
        format.js { render 'layouts/errors', locals: { object: @parqueadero } }
      end
    end
  end

  def update
    respond_to do |format|
      if @parqueadero.update(parqueadero_params)
        flash[:notice] = t(:notice_actualiza_msj)
        format.js
      else
        format.js { render 'layouts/errors', locals: { object: @parqueadero } }
      end
    end
  end

  def destroy
    @parqueadero.destroy
    flash['success'] = 'Eliminado con éxito'
    respond_to { |format| format.js }
  end

  private

  def set_parqueadero
    @parqueadero = Parqueadero.find(params[:id])
  end

  def parqueadero_params
    params.require(:parqueadero).permit(
      :fecha_hora, :tipo, :placa_id, :instructor_id,
      :kilometraje_entrada, :cant_combustible
    )
  end

  def set_layout
    'application_admin'
  end
end
