class Personastramiteshora < ActiveRecord::Base
  belongs_to :personastramite
  belongs_to :instructor

  validates_presence_of :fecha, :practicas, :teoricas, :taller, :instructor_id

  def dtotal
    valor = 0
    valor = self.practicas.to_i + self.teoricas.to_i + self.taller.to_i
    return valor
  end
end
