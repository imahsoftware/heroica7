class Placa < ApplicationRecord
  belongs_to :user, optional: true
  belongs_to :instructor, optional: true

  validates :descripcion, presence: true

  # Ransack 3.x
  def self.ransackable_attributes(auth_object = nil)
    %w[descripcion marca linea modelo tipo_vehiculo estado user_id]
  end

  def self.ransackable_associations(auth_object = nil)
    []
  end
end
