# frozen_string_literal: true

module TiposviajesHelper
  def tiposviajes_index_path(*)
    '/tiposviajes'
  end

  def new_tiposviaje_path(*)
    '/tiposviajes/new'
  end

  def edit_tiposviaje_path(tiposviaje, *)
    "/tiposviajes/#{tiposviaje.id}/edit"
  end

  def tiposviaje_path(tiposviaje, *)
    "/tiposviajes/#{tiposviaje.id}"
  end
end
