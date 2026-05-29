# frozen_string_literal: true

class Viaje < ApplicationRecord
  belongs_to :tiposviaje
  has_many :viajesrecibos

  validates :tiposviaje_id, :identificacion, :nombre, :apellido, presence: true

  def self.buscar(tour, identificacion)
    scope = all
    if identificacion.to_s != ''
      scope = scope.where(identificacion: identificacion)
    end
    if tour.to_s != ''
      scope = scope.where(tiposviaje_id: tour)
    end
    if identificacion.to_s.blank? && tour.to_s.blank?
      scope = scope.where('DATE(created_at) = CURDATE()')
    end
    scope.order(:created_at)
  end
end
