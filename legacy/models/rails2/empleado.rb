class Empleado < ActiveRecord::Base
  has_many :empleadosnominas
  
  def destado
    if self.estado == 'A'
      return 'ACTIVO'
    elsif self.estado == 'I'
      return 'INACTIVO'
    end
  end
end
