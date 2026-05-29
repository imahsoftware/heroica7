class Empleadosnomina < ApplicationRecord
  belongs_to :empleado
  belongs_to :periodosliquidacion

  def self.generar(periodosliquidacion_id)
    return if Empleadosnomina.exists?(periodosliquidacion_id: periodosliquidacion_id)

    Empleado.where(estado: 'A').each do |empleado|
      nom = Empleadosnomina.new
      nom.empleado_id              = empleado.id
      nom.periodosliquidacion_id   = periodosliquidacion_id
      nom.salario                  = empleado.salario
      nom.dias                     = 15
      nom.horas_auto               = 0
      nom.horas_minus              = 0
      nom.horas_bus                = 0
      nom.bonificacion             = 0
      nom.incapacidad              = 0
      nom.ajuste                   = 0
      nom.seguro                   = 0
      nom.dotacion                 = 0
      nom.prestamo                 = 0

      if empleado.instructor.to_s != 'SI'
        nom.quincena  = (empleado.salario / 30.0) * 15
        nom.subtotal  = nom.quincena
        nom.salud     = (nom.quincena * 0.04).round
        nom.pension   = (nom.quincena * 0.04).round
        nom.auxilio   = (Parametro.find(22).valor.to_f / 30.0) * 15
        nom.total     = (nom.quincena + nom.auxilio - nom.salud - nom.pension).round
      end

      nom.save
    end
  end
end
