# frozen_string_literal: true

class ViajesController < ApplicationController
  before_action :set_viaje, only: [:show, :edit, :update, :destroy]

  layout :set_layout

  def index
    @viajes = Viaje.all
    respond_to { |format| format.html }
  end

  def busqueda
    @tiposviajes = Tiposviaje.order(:descripcion)
  end

  def buscar
    tour = params.dig(:ubicacion, :tour)
    identificacion = params[:identificacion]
    @viajes = Viaje.includes(:tiposviaje).buscar(tour, identificacion)

    if @viajes.count == 1
      redirect_to edit_viaje_path(@viajes.first)
    elsif @viajes.count.zero?
      flash[:notice] = 'No hay informacion de la busqueda'
      redirect_to busqueda_viajes_path
    else
      respond_to { |format| format.html }
    end
  rescue StandardError
    flash[:notice] = 'Debe digitar datos para la consulta'
    redirect_to busqueda_viajes_path
  end

  def informe
    @viajesrecibos = Viajesrecibo.includes(viaje: :tiposviaje).all
    respond_to do |format|
      format.xls do
        response.headers['Content-Type'] = 'application/vnd.ms-excel'
        response.headers['Content-Disposition'] =
          "attachment; filename=\"informe_#{Time.now.strftime('%Y_%m_%d_%X')}.xls\""
        response.headers['Cache-Control'] = ''
      end
    end
  end

  def show
    respond_to { |format| format.html }
  end

  def new
    @viaje = Viaje.new
    @tiposviajes = Tiposviaje.order(:descripcion)
    render 'viaje_form'
  end

  def edit
    @tiposviajes = Tiposviaje.order(:descripcion)
    respond_to { |format| format.html { render 'viaje_form' } }
  end

  def create
    @viaje = Viaje.new(viaje_params)
    @tiposviajes = Tiposviaje.order(:descripcion)
    if @viaje.save
      flash[:notice] = 'Registro Creado con Exito.'
      redirect_to edit_viaje_path(@viaje)
    else
      render 'viaje_form'
    end
  end

  def update
    @tiposviajes = Tiposviaje.order(:descripcion)
    if @viaje.update(viaje_params)
      flash[:notice] = 'Registro Actualizado con Exito.'
      redirect_to edit_viaje_path(@viaje)
    else
      render 'viaje_form'
    end
  end

  def destroy
    @viaje.destroy
    respond_to { |format| format.html { redirect_to viajes_url } }
  end

  private

  def set_viaje
    @viaje = Viaje.find(params[:id])
  end

  def viaje_params
    params.require(:viaje).permit(:tiposviaje_id, :identificacion, :nombre, :apellido,
                                  :peso, :horario, :habitacionhotel)
  end

  def set_layout
    'application_admin'
  end
end
