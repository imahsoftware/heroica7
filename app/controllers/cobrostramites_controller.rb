class CobrostramitesController < ApplicationController
  before_action :set_cobrostramite, only: [:show, :edit, :update, :destroy]

  layout :set_layout
  before_action :checkaccess

  def checkaccess
    return is_permit('cobrostramites')
  end

  def index
    # Carga categorías que tienen cobros para la vista agrupada
    @categorias_con_cobros = Categoria.joins(:cobrostramites)
                                      .distinct
                                      .order(:nombre)
    @cobrostramites_por_categoria = @categorias_con_cobros.each_with_object({}) do |cat, hash|
      hash[cat] = Cobrostramite.where(categoria_id: cat.id)
                               .includes(:tipostramite, :concepto, :user)
                               .order(:tipostramite_id, :concepto_id)
    end
    respond_to do |format|
      format.html
    end
  end

  def show
    respond_to { |format| format.js }
  end

  def new
    @cobrostramite = Cobrostramite.new
    @categorias   = Categoria.order(:nombre)
    @tipostramites = Tipostramite.order(:descripcion)
    @conceptos    = Concepto.order(:descripcion)
    respond_to { |format| format.js }
  end

  def edit
    @categorias   = Categoria.order(:nombre)
    @tipostramites = Tipostramite.order(:descripcion)
    @conceptos    = Concepto.order(:descripcion)
    respond_to { |format| format.js }
  end

  def create
    @cobrostramite = Cobrostramite.new(cobrostramite_params)
    @cobrostramite.user_id = is_admin
    respond_to do |format|
      if @cobrostramite.save
        flash[:notice] = t(:notice_crea_msj)
        format.js
      else
        @categorias    = Categoria.order(:nombre)
        @tipostramites = Tipostramite.order(:descripcion)
        @conceptos     = Concepto.order(:descripcion)
        format.js { render 'layouts/errors', locals: { object: @cobrostramite } }
      end
    end
  end

  def update
    respond_to do |format|
      if @cobrostramite.update(cobrostramite_params)
        flash[:notice] = t(:notice_actualiza_msj)
        format.js
      else
        @categorias    = Categoria.order(:nombre)
        @tipostramites = Tipostramite.order(:descripcion)
        @conceptos     = Concepto.order(:descripcion)
        format.js { render 'layouts/errors', locals: { object: @cobrostramite } }
      end
    end
  end

  def destroy
    @cobrostramite.destroy
    flash['success'] = 'Eliminado con éxito'
    respond_to { |format| format.js }
  end

  private

  def set_cobrostramite
    @cobrostramite = Cobrostramite.find(params[:id])
  end

  def cobrostramite_params
    params.require(:cobrostramite).permit(:categoria_id, :tipostramite_id, :concepto_id)
  end

  def set_layout
    'application_admin'
  end
end
