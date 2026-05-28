# frozen_string_literal: true

class Teorico < ApplicationRecord
  belongs_to :persona
  belongs_to :user,      optional: true
  belongs_to :categoria, optional: true

  after_create :generar_preguntas

  private

  def generar_preguntas
    i = 0
    [[1, 8], [2, 12], [3, 8], [4, 12]].each do |grupo, limite|
      preguntas = ::Pregunta
                    .where("id IN (SELECT DISTINCT pregunta_id FROM preguntascategorias WHERE categoria_id = ?) AND grupo = ?", categoria_id, grupo.to_s)
                    .order('RAND()')
                    .limit(limite)
      preguntas.each do |pregunta|
        i += 1
        ::Teoricosresultado.create!(
          teorico_id:    id,
          persona_id:    persona_id,
          pregunta_id:   pregunta.id,
          consecutivo:   i
        )
      end
    end
  end
end
