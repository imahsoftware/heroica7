# frozen_string_literal: true

class ViajesrecibosController < ApplicationController
  layout :set_layout

  def crearrecibo
    viaje_id = params[:viaje_id]
    tiposviaje = Tiposviaje.find(params[:tiposviaje])
    max_recibo = Viajesrecibo.maximum(:nro_recibo)
    nro_recibo = max_recibo.nil? ? 1000 : max_recibo.to_i + 1

    Viajesrecibo.create!(
      viaje_id: viaje_id,
      nro_recibo: nro_recibo,
      estado: 0,
      valor: tiposviaje.valor
    )

    flash[:notice] = 'El recibo ha sido generado con Exito.'
    redirect_to edit_viaje_path(viaje_id)
  end

  def eliminar
    Viajesrecibo.where(viaje_id: params[:viaje_id], estado: 0).find_each do |viajesrecibo|
      viajesrecibo.update!(estado: 1)
    end
    flash[:notice] = 'El recibo ha sido Anulado con Exito.'
    redirect_to edit_viaje_path(params[:viaje_id])
  end

  def show
    @viajesrecibo = Viajesrecibo.includes(viaje: :tiposviaje)
                                .find_by(viaje_id: params[:viaje_id], estado: 0)
  end

  private

  def set_layout
    action_name == 'show' ? 'cartas' : 'application_admin'
  end
end
