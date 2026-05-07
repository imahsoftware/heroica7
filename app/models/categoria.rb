class Categoria < ApplicationRecord
  has_many :cobrostramites

  validates :nombre, presence: true

  def self.ransackable_attributes(auth_object = nil)
    %w[nombre codigo_nuevo codigo tipo_servicio]
  end

  def self.ransackable_associations(auth_object = nil)
    []
  end
end
