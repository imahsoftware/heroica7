class Tiposcombustible < ApplicationRecord
  has_many :combustibles

  validates :descripcion, presence: true

  def self.ransackable_attributes(auth_object = nil)
    %w[descripcion]
  end

  def self.ransackable_associations(auth_object = nil)
    []
  end
end
