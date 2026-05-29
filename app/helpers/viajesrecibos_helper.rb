# frozen_string_literal: true

module ViajesrecibosHelper
  def crearrecibo_viajesrecibos_path(viaje_id:, tiposviaje:)
    "/viajesrecibos/crearrecibo?viaje_id=#{viaje_id}&tiposviaje=#{tiposviaje}"
  end

  def eliminar_viajesrecibos_path(viaje_id:)
    "/viajesrecibos/eliminar?viaje_id=#{viaje_id}"
  end

  def show_viajesrecibos_path(viaje_id:)
    "/viajesrecibos/show?viaje_id=#{viaje_id}"
  end
end
