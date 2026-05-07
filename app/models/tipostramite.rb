class Tipostramite < ApplicationRecord
  validates :descripcion, presence: true

  def self.ransackable_attributes(auth_object = nil)
    %w[descripcion ministerio]
  end

  def self.ransackable_associations(auth_object = nil)
    []
  end
end
