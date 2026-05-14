# frozen_string_literal: true

class Empleado < ApplicationRecord
  has_many :empleadosnominas

  def destado
    if estado == 'A'
      'ACTIVO'
    elsif estado == 'I'
      'INACTIVO'
    end
  end
end
