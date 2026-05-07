class Instructor < ApplicationRecord
  validates :nombre, presence: true

  def self.ransackable_attributes(auth_object = nil)
    %w[identificacion nombre nro_licencia nro_licenciai anno_evaluacion]
  end

  def self.ransackable_associations(auth_object = nil)
    []
  end
end
