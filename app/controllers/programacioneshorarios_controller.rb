# frozen_string_literal: true

class ProgramacioneshorariosController < ApplicationController
  layout :determine_layout

  def horario
    ActiveRecord::Base.connection.execute('delete from programacioneshorarios where persona_id is null')
    unless Programacionesrespaldo.where('DATE(created_at) = CURDATE()').exists?
      ActiveRecord::Base.connection.execute("insert into programacionesrespaldos
                                             (fecha_captura,programacioneshorario_id,persona_id,tiposhorario_id,placa_id,instructor_id,
                                              fecha_inicial,nro_clases,fecha_final,recoje,user_id,user_actualiza,ph_created_at,ph_updated_at,
                                              observacion,enespera,fecha_teoria,estado,created_at,updated_at)
                                             select cast(curdate()-1 as date),id,persona_id,tiposhorario_id,placa_id,instructor_id,
                                                    fecha_inicial,nro_clases,fecha_final,recoje,user_id,user_actualiza,created_at,updated_at,
                                                    observacion,enespera,fecha_teoria,estado,now(),now()
                                             from programacioneshorarios")
    end
    @placas = Placa.where(estado: 'A').includes(:instructor).order(:descripcion)
    @tiposhorarios = Tiposhorario.all
    @instructores = Instructor.order(:nombre)
  end

  def informe
    if params.dig(:ubicacion, :inicial).blank? && params.dig(:ubicacion, :final).blank?
      flash[:notice] = 'Debe digitar datos para la consulta'
      redirect_to horario_programacioneshorarios_path
    else
      scope = Personasclase.where(
        fecha_clase: params[:ubicacion][:inicial]..params[:ubicacion][:final]
      ).order(:persona_id)
      scope = scope.where(instructor_id: params[:ubicacion][:instructor_id]) if params[:ubicacion][:instructor_id].present?
      @personasclases = scope
      @fch1 = params[:ubicacion][:inicial]
      @fch2 = params[:ubicacion][:final]
    end
  end

  def progclases
    if params.dig(:ubicacion, :inicial).blank? && params.dig(:ubicacion, :final).blank?
      flash[:notice] = 'Debe digitar datos para la consulta'
      redirect_to horario_programacioneshorarios_path
    else
      scope = Programacioneshorario.where(
        fecha_inicial: params[:ubicacion][:inicial]..params[:ubicacion][:final]
      ).order(:persona_id)
      scope = scope.where(instructor_id: params[:ubicacion][:instructor_id]) if params[:ubicacion][:instructor_id].present?
      @programacioneshorarios = scope
      @fch1 = params[:ubicacion][:inicial]
      @fch2 = params[:ubicacion][:final]
    end
  end

  def new
    @tiposhorario = params[:tiposhorario_id]
    @placa = params[:placa_id]
    @programacioneshorario = Programacioneshorario.new(
      tiposhorario_id: params[:tiposhorario_id],
      placa_id: params[:placa_id]
    )
    render :programacioneshorario_form
  end

  def edit
    @programacioneshorario = Programacioneshorario.find(params[:id])
    render :programacioneshorario_form
  end

  def marcarclase
    obs = ''
    ActiveRecord::Base.connection.execute('truncate table categoriasalertas')
    ActiveRecord::Base.connection.execute(
      "insert into categoriasalertas
         (persona_id, categoria_id, practicas, alertaspracticas, cantclases, estado, user_id, created_at, updated_at)
       select distinct p.persona_id, t.categoria_id, c.practicas, c.alertpracticas, count(9), 'P', null, curdate(), curdate()
       from   personasclases p, personastramites t, categorias c
       where  p.persona_id = t.persona_id
       and    t.categoria_id = c.id
       group by p.persona_id, t.categoria_id, c.practicas
      "
    )
    ActiveRecord::Base.connection.execute('delete from categoriasalertas where alertaspracticas > cantclases')
    ActiveRecord::Base.connection.execute("delete from categoriasalertas where persona_id in (select persona_id from facturas where estado = 'C')")

    @programacioneshorario = Programacioneshorario.find(params[:id])
    validafecha = Objeto.find_by_sql(
      "select 'X' valor from dual where curdate() between '#{@programacioneshorario.fecha_inicial}' and '#{@programacioneshorario.fecha_final}'"
    ).first&.valor.to_s

    if Categoriasalerta.exists?(persona_id: @programacioneshorario.persona_id)
      if permiso('autorizacionclase', 'A').to_s == 'S'
        dejarpasar = 'S'
        obs = 'Usuario con autorización especial'
      else
        dejarpasar = 'N'
      end
    else
      dejarpasar = 'S'
    end

    if validafecha == 'X' || permiso('personastramiteesp', 'A').to_s == 'S'
      if dejarpasar == 'S'
        @placa = Placa.find(@programacioneshorario.placa_id)
        personasclase = Personasclase.new(
          persona_id: @programacioneshorario.persona_id,
          fecha_clase: Time.zone.now,
          tiposhorario_id: @programacioneshorario.tiposhorario_id,
          placa_id: @programacioneshorario.placa_id,
          instructor_id: @placa.instructor_id,
          user_id: is_admin
        )
        personasclase.save
        flash[:personasclase] = if permiso('personastramiteesp', 'A').to_s == 'S'
                                   "Clase registrada con exito. Perfil Especial...#{obs}"
                                 else
                                   "Clase registrada con exito.#{obs}"
                                 end
      else
        flash[:personasclase] = 'El usuario debe realizar la cancelacion de la factura para permitir continuar con las demas clases'
      end
    else
      flash[:personasclase] = 'La fecha programada del Alumno ya fue cumplida o no ha iniciado.. No se puede registrar la clase.'
    end
  end

  def create
    @programacioneshorario = Programacioneshorario.new(programacioneshorario_params)
    @programacioneshorario.user_id = is_admin

    if permiso('autorizacionprogramacion', 'A').to_s == 'S'
      save_programacion('Programacion Creado con Exito. Usuario con autorización especial')
    elsif Abono.exists?(estado: 'C', factura_id: Factura.where(persona_id: @programacioneshorario.persona_id).select(:id))
      if Personastramite.exists?(persona_id: @programacioneshorario.persona_id, placa_id: @programacioneshorario.placa_id)
        save_programacion('Programacion Creado con Exito.')
      else
        @error_message = 'Hay diferencias entre el vehículo e instructor seleccionado para la Clase y el registrado en el Trámite. Verifique!!!'
        render :programacioneshorario_form
      end
    else
      @error_message = 'El alumno no tiene pago registrado o la factura está pendiente de abono. No se puede realizar la programación. Verifique!!!'
      render :programacioneshorario_form
    end
  end

  def update
    @programacioneshorario = Programacioneshorario.find(params[:id])
    @programacioneshorario.user_actualiza = is_admin
    attrs = programacioneshorario_params.to_h
    attrs[:fecha_final] = fechaprog(attrs['fecha_inicial'], attrs['nro_clases'])

    if @programacioneshorario.update(attrs)
      flash[:notice] = 'Programacion Actualizada con Exito.'
      redirect_to edit_programacioneshorario_path(@programacioneshorario)
    else
      render :programacioneshorario_form
    end
  rescue StandardError
    redirect_to edit_programacioneshorario_path(@programacioneshorario)
  end

  def destroy
    @programacioneshorario = Programacioneshorario.find(params[:id])
    ActiveRecord::Base.connection.execute("update programacioneshorarios set estado = 'I' where id = #{@programacioneshorario.id}")
    head :ok
  end

  private

  def save_programacion(message)
    @programacioneshorario.instructor_id = Placa.find(@programacioneshorario.placa_id).instructor_id
    @programacioneshorario.fecha_final = fechaprog(@programacioneshorario.fecha_inicial,
                                                   @programacioneshorario.nro_clases.to_i + 2)
    @programacioneshorario.estado = 'A'

    if @programacioneshorario.save
      flash[:notice] = message
      redirect_to horario_programacioneshorarios_path
    else
      @error_message = "No se pudo guardar: #{@programacioneshorario.errors.full_messages.join(', ')}"
      render :programacioneshorario_form
    end
  rescue StandardError => e
    Rails.logger.error "save_programacion error: #{e.class} — #{e.message}\n#{e.backtrace.first(5).join("\n")}"
    @error_message = "Error al guardar: #{e.message}"
    render :programacioneshorario_form
  end

  def programacioneshorario_params
    params.require(:programacioneshorario).permit(
      :tiposhorario_id, :placa_id, :persona_id, :fecha_inicial, :nro_clases,
      :recoje, :observacion, :enespera, :fecha_teoria
    )
  end

  def determine_layout
    if %w[horario marcarclase informe progclases].include?(action_name)
      'informes'
    else
      'basico'
    end
  end
end
