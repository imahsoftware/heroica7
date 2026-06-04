# frozen_string_literal: true

class Parqueadero < ApplicationRecord
  belongs_to :placa
  belongs_to :instructor, optional: true

  TIPOS = %w[ENTRADA SALIDA].freeze

  validates :placa_id, presence: true
  validates :fecha_hora, presence: true
  validates :tipo, inclusion: { in: TIPOS }, allow_blank: true

  def self.ransackable_attributes(_auth_object = nil)
    %w[fecha_hora tipo placa_id instructor_id kilometraje_entrada cant_combustible]
  end

  def self.ransackable_associations(_auth_object = nil)
    %w[placa instructor]
  end
end
