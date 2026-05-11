class Egreso < ApplicationRecord
  belongs_to :user,      optional: true
  belongs_to :proveedor, optional: true
  has_many   :egresosimagenes, class_name: 'Egresosimagen',
                               foreign_key: 'egreso_id',
                               dependent: :destroy

  validates :nro_egreso,  presence: true
  validates :fecha,       presence: true
  validates :valor,       presence: true
  validates :proveedor_id, presence: true

  FORMAS_PAGO = %w[EFECTIVO BANCO TRANSFERENCIA CONSIGNACION CHEQUE].freeze

  # Búsqueda avanzada equivalente al self.search del legacy Rails 2.
  # Filtra por nro_egreso, observacion, proveedor_id y rango de fechas.
  # Si no se pasan filtros devuelve los registros del día actual.
  def self.search(egreso, fchinicial, fchfinal)
    scope = all

    if egreso.nro_egreso.present?
      scope = scope.where(nro_egreso: egreso.nro_egreso)
    end

    if egreso.observacion.present?
      scope = scope.where('UPPER(observacion) LIKE ?', "%#{egreso.observacion.upcase}%")
    end

    if egreso.proveedor_id.present?
      scope = scope.where(proveedor_id: egreso.proveedor_id)
    end

    if fchinicial.present? && fchfinal.present?
      scope = scope.where(fecha: fchinicial..fchfinal)
    end

    if scope == all
      # Sin filtros: devuelve registros del día de hoy
      scope = scope.where(fecha: Date.today)
    end

    scope.order(:created_at)
  end

  def self.ransackable_attributes(auth_object = nil)
    %w[nro_egreso observacion fecha proveedor_id forma_pago valor valor_bruto valor_iva]
  end

  def self.ransackable_associations(auth_object = nil)
    %w[proveedor]
  end
end
