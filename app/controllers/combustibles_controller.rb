# frozen_string_literal: true

class CombustiblesController < ApplicationController
  before_action :set_combustible, only: [:show, :edit, :update, :destroy]

  layout :set_layout
  before_action :checkaccess

  def checkaccess
    is_permit('combustibles') || is_permit('combustible')
  end

  def index
    @q = Combustible.includes(:placa, :tiposcombustible).ransack(params[:q])
    @q.sorts = 'fecha desc' if @q.sorts.empty?
    @combustibles = @q.result.paginate(page: params[:page], per_page: 15)
    respond_to { |format| format.html }
  end

  def show
    respond_to { |format| format.js }
  end

  def new
    @active_record = Combustible.find(params[:active_id]) if params[:active_id].present?
    @combustible   = Combustible.new
    respond_to { |format| format.js }
  end

  def edit
    @active_record = Combustible.find(params[:active_id]) if params[:active_id].present?
    respond_to { |format| format.js }
  end

  def create
    @combustible = Combustible.new(combustible_params)
    respond_to do |format|
      if @combustible.save
        flash[:notice] = t(:notice_crea_msj)
        format.js
      else
        format.js { render 'layouts/errors', locals: { object: @combustible } }
      end
    end
  end

  def update
    respond_to do |format|
      if @combustible.update(combustible_params)
        flash[:notice] = t(:notice_actualiza_msj)
        format.js
      else
        format.js { render 'layouts/errors', locals: { object: @combustible } }
      end
    end
  end

  def destroy
    @combustible.destroy
    flash['success'] = 'Eliminado con éxito'
    respond_to { |format| format.js }
  end

  private

  def set_combustible
    @combustible = Combustible.find(params[:id])
  end

  def combustible_params
    params.require(:combustible).permit(
      :fecha, :placa_id, :tiposcombustible_id,
      :kilometraje, :odometro, :horometro,
      :galones, :valor_galon, :valor_total, :nro_clases
    )
  end

  def set_layout
    'application_admin'
  end
end
