# frozen_string_literal: true

class TiposviajesController < ApplicationController
  before_action :set_tiposviaje, only: [:show, :edit, :update, :destroy]

  layout :set_layout
  #before_action :checkaccess

  def checkaccess
    is_permit('tiposviajes')
  end

  def index
    @q = Tiposviaje.ransack(params[:q])
    @tiposviajes = @q.result.order(:descripcion).paginate(page: params[:page], per_page: 15)
    respond_to { |format| format.html }
  end

  def show
    respond_to { |format| format.js }
  end

  def new
    @active_record = Tiposviaje.find(params[:active_id]) if params[:active_id].present?
    @tiposviaje = Tiposviaje.new
    respond_to { |format| format.js }
  end

  def edit
    @active_record = Tiposviaje.find(params[:active_id]) if params[:active_id].present?
    respond_to { |format| format.js }
  end

  def create
    @tiposviaje = Tiposviaje.new(tiposviaje_params)
    respond_to do |format|
      if @tiposviaje.save
        flash[:notice] = t(:notice_crea_msj)
        format.js
      else
        format.js { render 'layouts/errors', locals: { object: @tiposviaje } }
      end
    end
  end

  def update
    respond_to do |format|
      if @tiposviaje.update(tiposviaje_params)
        flash[:notice] = t(:notice_actualiza_msj)
        format.js
      else
        format.js { render 'layouts/errors', locals: { object: @tiposviaje } }
      end
    end
  end

  def destroy
    @tiposviaje.destroy
    flash['success'] = 'Eliminado con éxito'
    respond_to { |format| format.js }
  end

  private

  def set_tiposviaje
    @tiposviaje = Tiposviaje.find(params[:id])
  end

  def tiposviaje_params
    params.require(:tiposviaje).permit(:descripcion, :valor)
  end

  def set_layout
    'application_admin'
  end
end
