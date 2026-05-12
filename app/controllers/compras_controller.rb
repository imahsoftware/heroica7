class ComprasController < ApplicationController
  before_action :set_compra, only: [:edit, :update, :destroy]

  layout :set_layout
  before_action :checkaccess

  def checkaccess
    return is_permit('compras')
  end

  def index
    @q = Compra.ransack(params[:q])
    @compras = @q.result.paginate(page: params[:page], per_page: 15)
    respond_to do |format|
      format.html
    end
  end

  def new
    @compra = Compra.new
    respond_to do |format|
      format.html { render 'compra_form' }
      format.js   { head :not_acceptable }
    end
  end

  def edit
    @comprasdetalle = Comprasdetalle.new
    respond_to do |format|
      format.html { render 'compra_form' }
    end
  end

  def create
    @compra = Compra.new(compra_params)
    @compra.user_id = is_admin
    if @compra.save
      flash[:notice] = t(:notice_crea_msj)
      redirect_to edit_compra_path(@compra)
    else
      @comprasdetalle = Comprasdetalle.new
      render 'compra_form'
    end
  end

  def update
    @compra.user_actualiza = is_admin
    if @compra.update(compra_params)
      flash[:notice] = t(:notice_actualiza_msj)
      redirect_to edit_compra_path(@compra)
    else
      @comprasdetalle = Comprasdetalle.new
      render 'compra_form'
    end
  rescue
    redirect_to edit_compra_path(@compra)
  end

  def destroy
    @compra.destroy
    flash[:notice] = 'El registro ha sido borrado con Éxito.'
    respond_to do |format|
      format.html { redirect_to compras_url }
      format.js
    end
  end

  private

  def set_compra
    @compra = Compra.find(params[:id])
  end

  def compra_params
    params.require(:compra).permit!
  end

  def set_layout
    'application_admin'
  end
end
