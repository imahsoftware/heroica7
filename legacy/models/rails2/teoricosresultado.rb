class Teoricosresultado < ActiveRecord::Base
  belongs_to :persona

  def self.estadopregunta(id,opc)
    resultado = "I"
    @preguntasrespuestas = Preguntasrespuesta.find_all_by_pregunta_id(id)
    @preguntasrespuestas.each do |preguntasrespuesta|
      if preguntasrespuesta.respuesta.to_s == opc
        resultado = "C"
      end
    end
    return resultado
  end

  def destado
    if self.estado == 'C'
      return 'CORRECTA'
    elsif self.estado == 'I'
      return 'INCORRECTA'
    end
  end
end
