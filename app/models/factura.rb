# frozen_string_literal: true

class Factura < ApplicationRecord
  belongs_to :user,         optional: true
  belongs_to :persona,      optional: true
  belongs_to :categoria,    optional: true
  belongs_to :tipostramite, optional: true
  has_many   :personastramites
  has_many   :detallesfacturas
  has_many   :abonos

  def destado
    case estado.to_s
    when 'P' then 'PENDIENTE'
    when 'A' then 'ANULADO'
    when 'C' then 'CANCELADO'
    end
  end

  def self.buscar(buscarident, buscarnombre, buscarfactura, buscarabono)
    cadena     = []
    conditions = []

    if buscarident.present?
      cadena << 'persona_id IN (SELECT id FROM personas WHERE identificacion = ?)'
      conditions << buscarident.to_s
    end
    if buscarnombre.present?
      cadena << 'persona_id IN (SELECT id FROM personas WHERE autobuscar LIKE ?)'
      conditions << "%#{buscarnombre.upcase}%"
    end
    if buscarfactura.present?
      cadena << 'nro_factura = ?'
      conditions << buscarfactura.to_s
    end
    if buscarabono.present?
      cadena << 'id IN (SELECT factura_id FROM abonos WHERE nro_abono = ?)'
      conditions << buscarabono.to_s
    end

    if cadena.any?
      where([cadena.join(' AND ')] + conditions).order(:nro_factura)
    else
      where('DATE(created_at) = CURDATE()').order(:nro_factura)
    end
  end
end
