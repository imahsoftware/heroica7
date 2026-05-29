# frozen_string_literal: true

class Programacioneshorario < ApplicationRecord
  belongs_to :persona
  belongs_to :tiposhorario, optional: true
  belongs_to :placa,        optional: true
  belongs_to :instructor,   optional: true

  validates :persona_autobuscar, :fecha_inicial, :nro_clases, presence: true

  def persona_autobuscar
    persona.autobuscar if persona
  end

  def persona_autobuscar=(autobuscar)
    return if autobuscar.blank?

    self.persona = Persona.find_by(autobuscar: autobuscar)
  end

  def destado
    case estado
    when 'A' then 'ACTIVA'
    when 'I' then 'FINALIZADA'
    end
  end
end
