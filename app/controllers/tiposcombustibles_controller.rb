class TiposcombustiblesController < ApplicationController
  before_action :set_tiposcombustible, only: [:show, :edit, :update, :destroy]

  layout :set_layout
  before_action :checkaccess

  def checkaccess
    return is_permit('tiposcombustibles')
  end

  def index
    @q = Tiposcombustible.ransack(params[:q])
    @tiposcombustibles = @q.result.paginate(page: params[:page], per_page: 15)
    respond_to do |format|
      format.html
    end
  end

  def show
    respond_to { |format| format.js }
  end

  def new
    @active_record = Tiposcombustible.find(params[:active_id]) if params[:active_id].present?
    @tiposcombustible = Tiposcombustible.new
    respond_to { |format| format.js }
  end

  def edit
    @active_record = Tiposcombustible.find(params[:active_id]) if params[:active_id].present?
    respond_to { |format| format.js }
  end

  def create
    @tiposcombustible = Tiposcombustible.new(tiposcombustible_params)
    respond_to do |format|
      if @tiposcombustible.save
        flash[:notice] = t(:notice_crea_msj)
        format.js
      else
        format.js { render 'layouts/errors', locals: { object: @tiposcombustible } }
      end
    end
  end

  def update
    respond_to do |format|
      if @tiposcombustible.update(tiposcombustible_params)
        flash[:notice] = t(:notice_actualiza_msj)
        format.js
      else
        format.js { render 'layouts/errors', locals: { object: @tiposcombustible } }
      end
    end
  end

  def destroy
    @tiposcombustible.destroy
    flash['success'] = 'Eliminado con éxito'
    respond_to { |format| format.js }
  end

  private

  def set_tiposcombustible
    @tiposcombustible = Tiposcombustible.find(params[:id])
  end

  def tiposcombustible_params
    params.require(:tiposcombustible).permit(:descripcion)
  end

  def set_layout
    'application_admin'
  end
end
