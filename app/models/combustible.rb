# frozen_string_literal: true

class Combustible < ApplicationRecord
  belongs_to :placa
  belongs_to :tiposcombustible

  validates :placa_id, presence: true
  validates :tiposcombustible_id, presence: true
  validates :fecha, presence: true

  scope :by_placa, ->(placa_id) { where(placa_id: placa_id) if placa_id.present? }

  def self.ransackable_attributes(_auth_object = nil)
    %w[fecha kilometraje odometro horometro galones valor_galon valor_total nro_clases placa_id tiposcombustible_id]
  end

  def self.ransackable_associations(_auth_object = nil)
    %w[placa tiposcombustible]
  end
end
