class Empleadosnomina < ActiveRecord::Base
  belongs_to :empleado
  belongs_to :periodosliquidacion

  def self.generar(peridosliquidacion_id)
    if Empleadosnomina.exists?(["periodosliquidacion_id = #{peridosliquidacion_id}"]) == false
      @empleados = Empleado.find_all_by_estado("A")
      @empleados.each do |empleado|
        @empleadosnomina = Empleadosnomina.new
        @empleadosnomina.empleado_id = empleado.id
        @empleadosnomina.periodosliquidacion_id = peridosliquidacion_id
        @empleadosnomina.salario = empleado.salario
        @empleadosnomina.dias = 15
        if empleado.instructor.to_s != "SI"
            @empleadosnomina.quincena = ((empleado.salario/30) * 15 )
            @empleadosnomina.subtotal = @empleadosnomina.quincena
            @empleadosnomina.salud = @empleadosnomina.quincena * 0.04
            @empleadosnomina.pension = @empleadosnomina.quincena * 0.04
            @empleadosnomina.auxilio = (Parametro.find(22).valor.to_f / 30) * 15.to_f
            @empleadosnomina.total = (@empleadosnomina.quincena + @empleadosnomina.auxilio - (@empleadosnomina.salud + @empleadosnomina.pension))
        end
        @empleadosnomina.horas_auto = 0
        @empleadosnomina.horas_minus = 0
        @empleadosnomina.horas_bus = 0
        @empleadosnomina.bonificacion = 0
        @empleadosnomina.incapacidad = 0
        @empleadosnomina.ajuste = 0
        @empleadosnomina.seguro = 0
        @empleadosnomina.dotacion = 0
        @empleadosnomina.prestamo = 0
        @empleadosnomina.save
      end
    end
  end
  
end
