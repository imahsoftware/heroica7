class EgresosController < ApplicationController
  before_action :set_egreso, only: [:show, :edit, :update, :destroy]

  layout :set_layout
  # before_action :checkaccess
  #
  # def checkaccess
  #   return is_permit('egresos')
  # end

  # Ingreso rápido desde el index
  def add_egreso
    @egreso = Egreso.new(egreso_params)
    @egreso.user_id = is_admin
    @egreso.save
    @egresos = Egreso.order(created_at: :desc).all
    respond_to do |format|
      if @egreso.save
        format.html { redirect_to egresos_path }
        format.js
      else
        format.html { redirect_to egresos_path }
        format.js
      end
    end
  end

  def index
    @egresos = Egreso.order(created_at: :desc).all
    respond_to do |format|
      format.html
    end
  end

  def show
    @egreso = Egreso.find(params[:id])
    respond_to do |format|
      format.html
    end
  end

  def new
    @egreso = Egreso.new
    render 'egreso_form'
  end

  def busqueda
    # Muestra el formulario de búsqueda avanzada
  end

  def buscar
    @egreso              = Egreso.new
    @egreso.nro_egreso   = params[:buscarnroegreso]
    @egreso.observacion  = params[:buscarobs]
    @egreso.proveedor_id = params[:ubicacion][:proveedor_id]
    @egresos = Egreso.search(@egreso,
                             params[:ubicacion][:fchinicial],
                             params[:ubicacion][:fchfinal])
    if @egresos.count == 0 && params[:format] != 'xls'
      flash[:notice] = 'No hay resultados de la busqueda'
      redirect_to busqueda_egresos_path
    elsif @egresos.count == 1 && params[:format] != 'xls'
      redirect_to edit_egreso_path(@egresos.first)
    else
      respond_to do |format|
        format.html
        format.xls { render layout: false } if params[:format] == 'xls'
      end
    end
  end

  def edit
    @egresosimagen = Egresosimagen.new
    respond_to do |format|
      format.html { render 'egreso_form' }
    end
  end

  def create
    @egreso = Egreso.new(egreso_params)
    @egreso.user_id = is_admin
    if @egreso.save
      flash[:notice] = 'El registro ha sido registrado con Exito.'
      redirect_to edit_egreso_path(@egreso)
    else
      render 'egreso_form'
    end
  end

  def update
    @egreso.user_actualiza = is_admin
    if @egreso.update(egreso_params)
      flash[:notice] = 'El registro ha sido actualizado con Exito.'
      redirect_to edit_egreso_path(@egreso)
    else
      render 'egreso_form'
    end
  rescue StandardError
    redirect_to edit_egreso_path(@egreso)
  end

  def destroy
    @egreso.destroy
    respond_to do |format|
      format.html { redirect_to egresos_url }
    end
  end

  private

    def set_egreso
      @egreso = Egreso.find(params[:id])
    end

    def egreso_params
      params.require(:egreso).permit!
    end

    def set_layout
      'application_admin'
    end
end
