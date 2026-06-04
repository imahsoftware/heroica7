# frozen_string_literal: true

class MantenimientosController < ApplicationController
  before_action :set_mantenimiento, only: [:show, :edit, :update, :destroy]

  layout :set_layout
  before_action :checkaccess

  def checkaccess
    is_permit('mantenimientos') || is_permit('mantenimiento')
  end

  def index
    @placas = Placa.order(:descripcion)
    @q = Mantenimiento.includes(:placa, :instructor).ransack(params[:q])
    @q.sorts = 'fecha desc' if @q.sorts.empty?
    @mantenimientos = @q.result.paginate(page: params[:page], per_page: 15)
    respond_to { |format| format.html }
  end

  def show
    respond_to { |format| format.js }
  end

  def new
    @active_record  = Mantenimiento.find(params[:active_id]) if params[:active_id].present?
    @mantenimiento  = Mantenimiento.new
    @mantenimiento.placa_id = params[:placa_id] if params[:placa_id].present?
    respond_to { |format| format.js }
  end

  def edit
    @active_record = Mantenimiento.find(params[:active_id]) if params[:active_id].present?
    respond_to { |format| format.js }
  end

  def create
    @mantenimiento = Mantenimiento.new(mantenimiento_params)
    respond_to do |format|
      if @mantenimiento.save
        flash[:notice] = t(:notice_crea_msj)
        format.js
      else
        format.js { render 'layouts/errors', locals: { object: @mantenimiento } }
      end
    end
  end

  def update
    respond_to do |format|
      if @mantenimiento.update(mantenimiento_params)
        flash[:notice] = t(:notice_actualiza_msj)
        format.js
      else
        format.js { render 'layouts/errors', locals: { object: @mantenimiento } }
      end
    end
  end

  def destroy
    @mantenimiento.destroy
    flash['success'] = 'Eliminado con éxito'
    respond_to { |format| format.js }
  end

  private

  def set_mantenimiento
    @mantenimiento = Mantenimiento.find(params[:id])
  end

  def mantenimiento_params
    params.require(:mantenimiento).permit(
      :placa_id, :descripcion, :fecha, :eficacia, :kilometraje, :taller,
      :costo_repuestos, :costo_obra, :costo, :observaciones, :fecha_salida, :instructor_id
    )
  end

  def set_layout
    'application_admin'
  end
end
