class Municipio < ApplicationRecord
  belongs_to :persona

  def nombreycodigo
    return self.descripcion.to_s
  end
end
