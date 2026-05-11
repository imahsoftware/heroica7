class EmpresasController < ApplicationController
  before_action :set_empresa, only: [:show, :edit, :update, :destroy]

  layout :set_layout
  before_action :checkaccess

  def checkaccess
    return is_permit('empresas')
  end

  # Ingreso rápido desde el index (equivalente al add_empresa del legacy)
  def add_empresa
    @empresa = Empresa.new(empresa_params)
    @empresa.save
    @empresas = Empresa.all
    respond_to do |format|
      if @empresa.save
        format.html { redirect_to empresas_path }
        format.js
      else
        format.html { redirect_to empresas_path }
        format.js
      end
    end
  end

  def index
    @q = Empresa.ransack(params[:q])
    @empresas = @q.result.order(:nombre).paginate(page: params[:page], per_page: 20)
    respond_to do |format|
      format.html
    end
  end

  def show
    respond_to { |format| format.js }
  end

  def new
    @active_record = Empresa.find(params[:active_id]) if params[:active_id].present?
    @empresa = Empresa.new
    respond_to { |format| format.js }
  end

  def edit
    @active_record = Empresa.find(params[:active_id]) if params[:active_id].present?
    respond_to { |format| format.js }
  end

  def create
    @empresa = Empresa.new(empresa_params)
    respond_to do |format|
      if @empresa.save
        flash[:notice] = t(:notice_crea_msj)
        format.js
      else
        format.js { render 'layouts/errors', locals: { object: @empresa } }
      end
    end
  end

  def update
    respond_to do |format|
      if @empresa.update(empresa_params)
        flash[:notice] = t(:notice_actualiza_msj)
        format.js
      else
        format.js { render 'layouts/errors', locals: { object: @empresa } }
      end
    end
  end

  def destroy
    @empresa.destroy
    flash['success'] = 'Eliminado con éxito'
    respond_to { |format| format.js }
  end

  private

    def set_empresa
      @empresa = Empresa.find(params[:id])
    end

    def empresa_params
      params.require(:empresa).permit!
    end

    def set_layout
      'application_admin'
    end
end
