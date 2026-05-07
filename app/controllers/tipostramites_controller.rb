class TipostramitesController < ApplicationController
  before_action :set_tipostramite, only: [:show, :edit, :update, :destroy]

  layout :set_layout
  before_action :checkaccess

  def checkaccess
    return is_permit('tipostramites')
  end

  def index
    @q = Tipostramite.ransack(params[:q])
    @tipostramites = @q.result.paginate(page: params[:page], per_page: 15)
    respond_to do |format|
      format.html
    end
  end

  def show
    respond_to { |format| format.js }
  end

  def new
    @active_record = Tipostramite.find(params[:active_id]) if params[:active_id].present?
    @tipostramite = Tipostramite.new
    respond_to { |format| format.js }
  end

  def edit
    @active_record = Tipostramite.find(params[:active_id]) if params[:active_id].present?
    respond_to { |format| format.js }
  end

  def create
    @tipostramite = Tipostramite.new(tipostramite_params)
    respond_to do |format|
      if @tipostramite.save
        flash[:notice] = t(:notice_crea_msj)
        format.js
      else
        format.js { render 'layouts/errors', locals: { object: @tipostramite } }
      end
    end
  end

  def update
    respond_to do |format|
      if @tipostramite.update(tipostramite_params)
        flash[:notice] = t(:notice_actualiza_msj)
        format.js
      else
        format.js { render 'layouts/errors', locals: { object: @tipostramite } }
      end
    end
  end

  def destroy
    @tipostramite.destroy
    flash['success'] = 'Eliminado con éxito'
    respond_to { |format| format.js }
  end

  private

  def set_tipostramite
    @tipostramite = Tipostramite.find(params[:id])
  end

  def tipostramite_params
    params.require(:tipostramite).permit(:descripcion, :ministerio)
  end

  def set_layout
    'application_admin'
  end
end
