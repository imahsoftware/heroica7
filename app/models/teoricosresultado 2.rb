# frozen_string_literal: true

class Teoricosresultado < ApplicationRecord
  
  belongs_to :persona,  optional: true
  belongs_to :teorico,  optional: true
  belongs_to :pregunta, optional: true

  def self.estadopregunta(pregunta_id, opc)
    resultado = 'I'
    Preguntasrespuesta.where(pregunta_id: pregunta_id).find_each do |pr|
      resultado = 'C' if pr.respuesta.to_s == opc.to_s
    end
    resultado
  end

  def destado
    return 'CORRECTA' if estado == 'C'
    return 'INCORRECTA' if estado == 'I'
  end
end

