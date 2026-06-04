# frozen_string_literal: true

class Personastrampractica < ApplicationRecord
  belongs_to :personastramite
  belongs_to :user, optional: true

  # Legacy validates_inclusion por campo; columnas suelen ser string/varchar
  RANGOS_EVALUACION = {
    inspeva_dato2: 1..5, inspeva_dato3: 1..5, inspeva_dato4: 1..5, inspeva_dato5: 1..5,
    inspeva_dato7: 1..5, inspeva_dato8: 1..5, desteva_dato7: 1..5, desteva_dato8: 1..5,
    compeva_dato7: 1..5, compeva_dato8: 1..5,
    desteva_dato1: 1..4, desteva_dato3: 1..4, desteva_dato13: 1..4,
    desteva_dato2: 1..6, desteva_dato4: 1..6, desteva_dato5: 1..6,
    desteva_dato10: 1..6, desteva_dato12: 1..6,
    desteva_dato9: 1..8,
    inspeva_dato6: 1..10, inspeva_dato9: 1..10, inspeva_dato10: 1..10, inspeva_dato11: 1..10,
    inspeva_dato12: 1..10, inspeva_dato13: 1..10, inspeva_dato14: 1..10,
    desteva_dato6: 1..10, desteva_dato11: 1..10, desteva_dato14: 1..10, desteva_dato15: 1..10,
    compeva_dato1: 1..10, compeva_dato2: 1..10, compeva_dato3: 1..10, compeva_dato4: 1..10,
    compeva_dato5: 1..10, compeva_dato6: 1..10, compeva_dato9: 1..10,
    compeva_dato10: 1..10, compeva_dato11: 1..10
  }.freeze

  validate :validar_rangos_evaluacion, on: :update
  before_save :calcular_totales

  private

  def validar_rangos_evaluacion
    RANGOS_EVALUACION.each do |campo, rango|
      valor = self[campo]
      next if valor.blank?

      numero = Float(valor.to_s.strip)
      entero = numero.to_i
      unless numero == entero && rango.cover?(entero)
        errors.add(campo, '** Error')
      end
    rescue ArgumentError, TypeError
      errors.add(campo, '** Error')
    end
  end

  def calcular_totales
    self.cal_inspeccion = inspeva_dato11.to_f + inspeva_dato2.to_f + inspeva_dato3.to_f +
                         inspeva_dato4.to_f + inspeva_dato5.to_f + inspeva_dato6.to_f +
                         inspeva_dato7.to_f + inspeva_dato8.to_f + inspeva_dato9.to_f +
                         inspeva_dato10.to_f + inspeva_dato12.to_f + inspeva_dato13.to_f + inspeva_dato14.to_f
    self.punt_inspeccion = inspcal_dato11.to_f + inspcal_dato2.to_f + inspcal_dato3.to_f +
                          inspcal_dato4.to_f + inspcal_dato5.to_f + inspcal_dato6.to_f +
                          inspcal_dato7.to_f + inspcal_dato8.to_f + inspcal_dato9.to_f +
                          inspcal_dato10.to_f + inspcal_dato12.to_f + inspcal_dato13.to_f + inspcal_dato14.to_f
    self.cal_destreza = desteva_dato1.to_f + desteva_dato2.to_f + desteva_dato3.to_f +
                        desteva_dato4.to_f + desteva_dato5.to_f + desteva_dato6.to_f +
                        desteva_dato7.to_f + desteva_dato8.to_f + desteva_dato9.to_f +
                        desteva_dato10.to_f + desteva_dato11.to_f + desteva_dato12.to_f +
                        desteva_dato13.to_f + desteva_dato14.to_f + desteva_dato15.to_f
    self.punt_destreza = destcal_dato1.to_f + destcal_dato2.to_f + destcal_dato3.to_f +
                         destcal_dato4.to_f + destcal_dato5.to_f + destcal_dato6.to_f +
                         destcal_dato7.to_f + destcal_dato8.to_f + destcal_dato9.to_f +
                         destcal_dato10.to_f + destcal_dato11.to_f + destcal_dato12.to_f +
                         destcal_dato13.to_f + destcal_dato14.to_f + destcal_dato15.to_f
    self.cal_comportamiento = compeva_dato1.to_f + compeva_dato2.to_f + compeva_dato3.to_f +
                              compeva_dato4.to_f + compeva_dato5.to_f + compeva_dato6.to_f +
                              compeva_dato7.to_f + compeva_dato8.to_f + compeva_dato9.to_f +
                              compeva_dato10.to_f + compeva_dato11.to_f
    self.punt_comportamiento = compcal_dato1.to_f + compcal_dato2.to_f + compcal_dato3.to_f +
                               compcal_dato4.to_f + compcal_dato5.to_f + compcal_dato6.to_f +
                               compcal_dato7.to_f + compcal_dato8.to_f + compcal_dato9.to_f +
                               compcal_dato10.to_f + compcal_dato11.to_f
    self.calificacion = cal_inspeccion.to_f + cal_destreza.to_f + cal_comportamiento.to_f
    self.puntaje = punt_inspeccion.to_f + punt_destreza.to_f + punt_comportamiento.to_f
  end
end
