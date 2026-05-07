class CategoriasController < ApplicationController
  before_action :set_categoria, only: [:show, :edit, :update, :destroy]

  layout :set_layout
  before_action :checkaccess

  def checkaccess
    return is_permit('categorias')
  end

  def index
    @q = Categoria.ransack(params[:q])
    @categorias = @q.result.paginate(page: params[:page], per_page: 15)
    respond_to do |format|
      format.html
    end
  end

  def show
    respond_to { |format| format.js }
  end

  def new
    @active_record = Categoria.find(params[:active_id]) if params[:active_id].present?
    @categoria = Categoria.new
    respond_to { |format| format.js }
  end

  def edit
    @active_record = Categoria.find(params[:active_id]) if params[:active_id].present?
    respond_to { |format| format.js }
  end

  def create
    @categoria = Categoria.new(categoria_params)
    respond_to do |format|
      if @categoria.save
        flash[:notice] = t(:notice_crea_msj)
        format.js
      else
        format.js { render 'layouts/errors', locals: { object: @categoria } }
      end
    end
  end

  def update
    respond_to do |format|
      if @categoria.update(categoria_params)
        flash[:notice] = t(:notice_actualiza_msj)
        format.js
      else
        format.js { render 'layouts/errors', locals: { object: @categoria } }
      end
    end
  end

  def destroy
    @categoria.destroy
    flash['success'] = 'Eliminado con éxito'
    respond_to { |format| format.js }
  end

  private

  def set_categoria
    @categoria = Categoria.find(params[:id])
  end

  def categoria_params
    params.require(:categoria).permit(
      :nombre, :codigo_nuevo, :codigo, :tipo_servicio,
      :practicas, :teoricas, :taller, :alertpracticas
    )
  end

  def set_layout
    'application_admin'
  end
end
