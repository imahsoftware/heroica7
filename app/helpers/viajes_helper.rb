# frozen_string_literal: true

module ViajesHelper
  def busqueda_viajes_path(*)
    '/viajes/busqueda'
  end

  def buscar_viajes_path(*)
    '/viajes/buscar'
  end

  def informe_viajes_path(*)
    '/viajes/informe'
  end

  def new_viaje_path(*)
    '/viajes/new'
  end

  def edit_viaje_path(viaje, *)
    "/viajes/#{viaje.id}/edit"
  end

  def viaje_path(viaje, *)
    "/viajes/#{viaje.id}"
  end

  def viajes_path(*)
    '/viajes'
  end
end
