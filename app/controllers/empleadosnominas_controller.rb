# frozen_string_literal: true

class EmpleadosnominasController < ApplicationController
  before_action :require_user_login
  layout :set_layout

  def buscar
  end

  def nomina
    period_id = params.dig(:ubicacion, :periodosliquidacion_id).to_i
    if period_id.zero?
      flash[:notice] = 'Debe seleccionar un periodo'
      redirect_to buscar_empleadosnominas_path and return
    end

    Empleadosnomina.generar(period_id)

    Parametro.find(23).update(valor: period_id.to_s) rescue nil

    redirect_to edit_individual_empleadosnominas_path(datoid: period_id)
  end

  def edit_individual
    period_id = params.dig(:ubicacion, :periodosliquidacion_id).to_i
    period_id = params[:datoid].to_i if period_id.zero? && params[:datoid].present?

    if period_id.zero?
      flash[:notice] = 'Debe digitar datos para la consulta'
      redirect_to buscar_empleadosnominas_path and return
    end

    Parametro.find(23).update(valor: period_id.to_s) rescue nil

    @periodosliquidacion = Periodosliquidacion.find(period_id)
    @empleadosnominas    = Empleadosnomina.left_joins(:empleado)
                                          .where(empleadosnominas: { periodosliquidacion_id: period_id })
                                          .order(Arel.sql('COALESCE(empleados.nombre, empleadosnominas.empleado_id)'))
                                          .preload(:empleado)
  rescue ActiveRecord::RecordNotFound
    flash[:notice] = 'Periodo no encontrado'
    redirect_to buscar_empleadosnominas_path
  end

  def update_individual
    campos_numericos = %i[salario quincena horas_auto horas_minus horas_bus dias
                          bonificacion incapacidad subtotal ajuste salud pension
                          auxilio seguro dotacion prestamo total]

    params[:empleadosnominas]&.each do |id, attrs|
      nom = Empleadosnomina.find(id)
      # Limpiar formato numérico "5.000,00" → 5000.0
      permitted = attrs.permit(*campos_numericos, :observacion)
      campos_numericos.each do |campo|
        next unless permitted[campo].present?
        permitted[campo] = permitted[campo].to_s.gsub('.', '').gsub(',', '.')
      end
      nom.update(permitted)
    end
    flash[:notice] = 'Actualizada con Exito.'
    period_id = Parametro.find(23).valor.to_i rescue 0
    redirect_to edit_individual_empleadosnominas_path(datoid: period_id)
  end

  def tirilla
    @periodosliquidacion = Periodosliquidacion.find(params[:periodosliquidacion_id])
    @empleadosnominas    = Empleadosnomina.left_joins(:empleado)
                                          .where(empleadosnominas: { periodosliquidacion_id: params[:periodosliquidacion_id] })
                                          .order(Arel.sql('COALESCE(empleados.nombre, empleadosnominas.empleado_id)'))
                                          .preload(:empleado)
  end

  def informe
    @periodosliquidacion = Periodosliquidacion.find(params[:periodosliquidacion_id])
    @empleadosnominas    = Empleadosnomina.left_joins(:empleado)
                                          .where(empleadosnominas: { periodosliquidacion_id: params[:periodosliquidacion_id] })
                                          .order(Arel.sql('COALESCE(empleados.nombre, empleadosnominas.empleado_id)'))
                                          .preload(:empleado)
  end

  # GET /empleadosnominas/calcularvalor — devuelve JSON con los campos calculados
  def calcularvalor
    empleado   = Empleado.find(params[:pvr0].to_i)
    fu         = params[:pvr1].to_i   # id del registro de nómina
    horas_auto = params[:pvr2].to_i
    horas_minus= params[:pvr3].to_i
    horas_bus  = params[:pvr4].to_i
    dias       = params[:pvr5].to_i
    bonificacion = params[:pvr6].to_i
    ajuste     = params[:pvr7].to_i
    seguro     = params[:pvr8].to_i
    dotacion   = params[:pvr9].to_i
    prestamo   = params[:pvr10].to_i

    if empleado.instructor.to_s == 'SI'
      valor_auto  = Parametro.find(19).valor.to_i
      valor_bus   = Parametro.find(20).valor.to_i
      valor_minus = Parametro.find(21).valor.to_i
      subtotal    = (horas_auto * valor_auto) + (horas_bus * valor_bus) +
                    (horas_minus * valor_minus) + bonificacion
    else
      salario  = (empleado.salario / 30.0) * dias
      subtotal = (salario + bonificacion).round
    end

    val_trans = (Parametro.find(22).valor.to_f / 30.0) * dias
    salud     = ((subtotal + ajuste) * 0.04).round
    pension   = ((subtotal + ajuste) * 0.04).round
    auxilio   = val_trans.round
    total     = (subtotal + auxilio + prestamo + dotacion + ajuste + seguro - salud - pension).round

    render json: {
      id:       fu,
      subtotal: subtotal,
      salud:    salud,
      pension:  pension,
      auxilio:  auxilio,
      total:    total
    }
  end

  private

  def require_user_login
    redirect_to new_user_session_path unless user_signed_in?
  end

  def set_layout
    if %w[tirilla informe].include?(action_name)
      'informes'
    else
      'application'
    end
  end
end
