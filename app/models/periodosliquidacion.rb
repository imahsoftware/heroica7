class Periodosliquidacion < ApplicationRecord
  has_many :empleadosnominas

  def descripcion
    "#{inicio} - #{fin}"
  end
end
