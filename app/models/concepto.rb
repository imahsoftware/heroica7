class Concepto < ApplicationRecord
  belongs_to :user
  has_many :cobrostramites
  has_many :detallesfacturas

  validates_presence_of :descripcion, :valor, :propio, message: "* Obligatorio"

  def nombreconcepto
    if self.propio.to_s == 'S'
      return "<strong>Ingresos Propios</strong>"
    elsif self.propio.to_s == 'N'
      return "<em>Ingresos Terceros</em>"
    end
  end

end
