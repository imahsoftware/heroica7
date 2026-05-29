class Tiposviaje < ApplicationRecord
  has_many :viajes

  validates :descripcion, presence: true

  def self.ransackable_attributes(auth_object = nil)
    %w[descripcion valor]
  end

  def self.ransackable_associations(auth_object = nil)
    []
  end
end
