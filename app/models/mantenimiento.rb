# frozen_string_literal: true

class Mantenimiento < ApplicationRecord
  belongs_to :placa
  belongs_to :instructor, optional: true

  validates :placa_id, presence: true
  validates :fecha, presence: true

  def self.ransackable_attributes(_auth_object = nil)
    %w[
      placa_id descripcion fecha eficacia kilometraje taller
      costo_repuestos costo_obra costo observaciones fecha_salida instructor_id
    ]
  end

  def self.ransackable_associations(_auth_object = nil)
    %w[placa instructor]
  end
end
