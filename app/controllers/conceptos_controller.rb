class ConceptosController < ApplicationController
  before_action :set_concepto, only: [:show, :edit, :update, :destroy]

  layout :set_layout
  before_action :checkaccess

  def checkaccess
    return is_permit('conceptos')
  end

  def index
    @q = Concepto.ransack(params[:q])
    @conceptos = @q.result.paginate(page: params[:page], per_page: 15)
    respond_to do |format|
      format.html
    end
  end

  def show
    respond_to { |format| format.js }
  end

  def new
    @active_record = Concepto.find(params[:active_id]) if params[:active_id].present?
    @concepto = Concepto.new
    respond_to { |format| format.js }
  end

  def edit
    @active_record = Concepto.find(params[:active_id]) if params[:active_id].present?
    respond_to { |format| format.js }
  end

  def create
    @concepto = Concepto.new(concepto_params)
    @concepto.user_id = is_admin
    respond_to do |format|
      if @concepto.save
        flash[:notice] = t(:notice_crea_msj)
        format.js
      else
        format.js { render 'layouts/errors', locals: { object: @concepto } }
      end
    end
  end

  def update
    respond_to do |format|
      if @concepto.update(concepto_params)
        flash[:notice] = t(:notice_actualiza_msj)
        format.js
      else
        format.js { render 'layouts/errors', locals: { object: @concepto } }
      end
    end
  end

  def destroy
    @concepto.destroy
    flash['success'] = 'Eliminado con éxito'
    respond_to { |format| format.js }
  end

  private

  def set_concepto
    @concepto = Concepto.find(params[:id])
  end

  def concepto_params
    params.require(:concepto).permit(:descripcion, :valor)
  end

  def set_layout
    'application_admin'
  end
end
