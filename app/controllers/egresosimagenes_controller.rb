class EgresosimagenesController < ApplicationController
  before_action :set_egreso_and_egresosimagen, only: [:show, :destroy]

  def show
    respond_to { |format| format.js }
  end

  def new
    @active_record = Egresosimagen.find(params[:active_id]) if params[:active_id].present?
    @egreso        = Egreso.find(params[:egreso_id])
    @egresosimagen = Egresosimagen.new
    respond_to { |format| format.js }
  end

  def edit
    @active_record = Egresosimagen.find(params[:active_id]) if params[:active_id].present?
    @egresosimagen = Egresosimagen.find(params[:id])
    @egreso        = @egresosimagen.egreso
    respond_to { |format| format.js }
  end

  def create
    @egreso        = Egreso.find(params[:egreso_id])
    @egresosimagen = Egresosimagen.new(egresosimagen_params)
    @egresosimagen.egreso_id = @egreso.id
    @egresosimagen.user_id   = is_admin
    respond_to do |format|
      if @egresosimagen.save
        flash[:notice] = t(:notice_crea_msj)
        format.js
      else
        format.js { render 'layouts/errors', locals: { object: @egresosimagen } }
      end
    end
  end

  def update
    @egresosimagen = Egresosimagen.find(params[:id])
    @egreso        = @egresosimagen.egreso
    respond_to do |format|
      if @egresosimagen.update(egresosimagen_params)
        flash[:notice] = t(:notice_actualiza_msj)
        format.js
      else
        format.js { render 'layouts/errors', locals: { object: @egresosimagen } }
      end
    end
  end

  def destroy
    flash['success'] = 'Eliminado correctamente'
    @egresosimagen.destroy
    respond_to { |format| format.js }
  end

  private

    def set_egreso_and_egresosimagen
      @egreso        = Egreso.find(params[:egreso_id])
      @egresosimagen = Egresosimagen.find(params[:id]) if params[:id]
    end

    def egresosimagen_params
      params.require(:egresosimagen).permit!
    end
end
