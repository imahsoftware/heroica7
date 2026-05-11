class Programacioneshorario < ActiveRecord::Base
  belongs_to :tiposhorario
  belongs_to :placa
  belongs_to :persona
  belongs_to :instructor

  validates_presence_of :persona_autobuscar, :fecha_inicial, :nro_clases

  def persona_autobuscar
    persona.autobuscar if persona
  end

  def persona_autobuscar=(autobuscar)
    self.persona = Persona.find_or_create_by_autobuscar(autobuscar) unless autobuscar.blank?
  end

  def destado
    if self.estado == 'A'
      return 'ACTIVA'
    elsif self.estado == 'I'
      return 'FINALIZADA'
    end
  end
end
