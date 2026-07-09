# frozen_string_literal: true

class PersonastramitesController < ApplicationController
  before_action :set_persona
  before_action :set_personastramite, only: [:show, :edit, :update, :destroy,
                                             :registroclase, :registrosolicitud,
                                             :diploma, :acuerdocomercial,
                                             :teorico, :practica, :practicam,
                                             :crearfactura]

  layout :set_layout

  # GET /personas/:persona_id/personastramites  (usado desde el tab)
  def index
    @personastramites = @persona.personastramites.all
  end

  # GET /personas/:persona_id/personastramites/:id  (JS)
  def show
    respond_to { |format| format.js }
  end

  # GET /personas/:persona_id/personastramites/new  (JS)
  def new
    @active_record     = Personastramite.find(params[:active_id]) if params[:active_id].present?
    @personastramite   = Personastramite.new
    respond_to { |format| format.js }
  end

  # GET /personas/:persona_id/personastramites/:id/edit  (JS)
  def edit
    @active_record = Personastramite.find(params[:active_id]) if params[:active_id].present?
    respond_to { |format| format.js }
  end

  # POST /personas/:persona_id/personastramites
  def create
    @personastramite            = Personastramite.new(personastramite_params)
    @personastramite.user_id    = is_admin
    @personastramite.persona_id = @persona.id

    respond_to do |format|
      if @personastramite.save
        @personastramite_creada = @personastramite
        @personastramite        = Personastramite.new
        flash[:notice] = t(:notice_crea_msj)
        format.js
      else
        flash.now[:alert] = 'Corrija los campos marcados antes de guardar.'
        format.js { render 'layouts/errors', locals: { object: @personastramite } }
      end
    end
  end

  # PATCH/PUT /personas/:persona_id/personastramites/:id
  def update
    @personastramite_edit              = Personastramite.find(params[:id])
    @personastramite_edit.user_actualiza = is_admin
    respond_to do |format|
      if @personastramite_edit.update(personastramite_params)
        @personastramite_actualizada = @personastramite_edit
        @personastramite             = Personastramite.new
        flash[:notice] = t(:notice_actualiza_msj)
        format.js
      else
        @personastramite = @personastramite_edit
        flash.now[:alert] = 'Corrija los campos marcados antes de guardar.'
        format.js { render 'layouts/errors', locals: { object: @personastramite_edit } }
      end
    end
  end

  # DELETE /personas/:persona_id/personastramites/:id
  def destroy
    @personastramite_eliminada_id = @personastramite.id
    @personastramite.respaldo(is_admin)
    @personastramite.destroy
    @personastramite = Personastramite.new
    flash['success'] = 'Eliminado con exito'
    respond_to { |format| format.js }
  end

  # ── Acciones especiales del legacy ────────────────────────────────────────

  # GET /personas/:persona_id/personastramites/:id/registroclase
  def registroclase
    programacion = Programacioneshorario
                     .where(persona_id: @personastramite.persona_id)
                     .includes(:tiposhorario)
                     .last
    @horario      = programacion&.tiposhorario&.descripcion
    @fechainicial = programacion&.fecha_inicial&.strftime('%Y-%m-%d')
    respond_to do |format|
      format.html
      format.pdf { render_registroclase_pdf }
    end
  end

  # GET /personas/:persona_id/personastramites/:id/registrosolicitud
  def registrosolicitud
    programacion = Programacioneshorario
                     .where(persona_id: @personastramite.persona_id)
                     .includes(:tiposhorario)
                     .last
    @horario          = programacion&.tiposhorario&.descripcion
    @fechainicial     = programacion&.fecha_inicial&.strftime('%Y-%m-%d')
    @teohorario       = programacion&.fecha_teoria&.strftime('%I:%M %p')
    @teofechainicial  = programacion&.fecha_teoria&.strftime('%Y-%m-%d')
    respond_informe_pdf("registro_solicitud_#{@personastramite.id}")
  end

  # GET /personas/:persona_id/personastramites/:id/diploma
  def diploma
    @nombre = params[:nombredip]
    respond_informe_pdf("diploma_#{@personastramite.id}", orientation: 'Landscape')
  end

  # GET /personas/:persona_id/personastramites/:id/acuerdocomercial
  def acuerdocomercial
    @teoricas, @taller, @practicas = horas_por_categoria(@personastramite.categoria_id)
    respond_informe_pdf("acuerdo_comercial_#{@personastramite.id}")
  end

  # GET /personas/:persona_id/personastramites/:id/teorico
  def teorico
    if Teorico.exists?(
      persona_id:  @personastramite.persona_id,
      categoria_id: @personastramite.categoria_id,
      estado:      'PENDIENTE'
    )
      flash[:teorico] = 'Ya tiene un examen teorico programado. Verifique!!!'
    else
      t = Teorico.new(
        persona_id:   @personastramite.persona_id,
        user_id:      is_admin,
        categoria_id: @personastramite.categoria_id,
        estado:       'PENDIENTE'
      )
      t.save
      flash[:teorico] = 'Examen teorico programado con exito'
    end
  end

  # GET /personas/:persona_id/personastramites/:id/crearfactura
  def crearfactura
    if Personastramite.exists?(['id = ? AND factura_id IS NULL', @personastramite.id])
      nrofactura = is_factura

      factura                    = Factura.new
      factura.persona_id         = @persona.id
      factura.personastramite_id = @personastramite.id
      factura.tipostramite_id    = @personastramite.tipostramite_id
      factura.categoria_id       = @personastramite.categoria_id
      factura.nro_factura        = nrofactura
      factura.user_id            = is_admin
      factura.estado             = 'P'
      factura.save

      last_id          = Factura.maximum('id')
      valortotalfact   = 0

      cobrostramites = Cobrostramite.where(
        tipostramite_id: params[:tipostramite_id],
        categoria_id:    params[:categoria_id]
      )
      cobrostramites.each do |cobrostramite|
        det                    = Detallesfactura.new
        det.factura_id         = last_id
        det.tipostramite_id    = cobrostramite.tipostramite_id
        det.categoria_id       = cobrostramite.categoria_id
        det.concepto_id        = cobrostramite.concepto_id
        det.valor              = Concepto.find(cobrostramite.concepto_id).valor
        valortotalfact        += det.valor
        det.user_id            = is_admin
        det.save
      end

      ActiveRecord::Base.connection.execute(
        "UPDATE personastramites SET factura_id = #{last_id} WHERE id = #{@personastramite.id}"
      )
      ActiveRecord::Base.connection.execute(
        "UPDATE facturas SET valor = #{valortotalfact} WHERE id = #{last_id}"
      )
      flash[:factura] = "Factura Nro. #{nrofactura} Creada con exito."
    else
      flash[:factura] = 'Este tramite ya fue facturado.'
    end
  end

  # GET /personas/:persona_id/personastramites/:id/practica
  def practica
    pra = if Personastrapractica.exists?(personastramite_id: @personastramite.id)
            Personastrapractica.find_by(personastramite_id: @personastramite.id)
          else
            Personastrapractica.new(
              personastramite_id: @personastramite.id,
              user_id:            is_admin
            ).tap(&:save!)
          end
    redirect_to edit_personastrapractica_path(pra)
  end

  # GET /personas/:persona_id/personastramites/:id/practicam
  def practicam
    pra = if Personastrampractica.exists?(personastramite_id: @personastramite.id)
            Personastrampractica.find_by(personastramite_id: @personastramite.id)
          else
            Personastrampractica.new(
              personastramite_id: @personastramite.id,
              user_id:            is_admin
            ).tap(&:save!)
          end
    redirect_to edit_personastrampractica_path(pra)
  end

  private

  def set_persona
    @persona = Persona.find(params[:persona_id])
  end

  def set_personastramite
    @personastramite = Personastramite.find(params[:id])
  end

  def personastramite_params
    params.require(:personastramite).permit!
  end

  def set_layout
    if %w[crearfactura teorico].include?(action_name)
      'basico'
    elsif %w[registroclase registrosolicitud acuerdocomercial].include?(action_name)
      'informes'
    elsif action_name == 'diploma'
      'blank'
    else
      'application_personas'
    end
  end

  # Devuelve [teoricas, taller, practicas] según la categoría del trámite
  def horas_por_categoria(categoria_id)
    case categoria_id
    when 1 then [25,  3,  8]
    when 2 then [25,  3, 15]
    when 3 then [25,  5, 20]
    when 4 then [30,  5, 30]
    when 5, 6 then [20, 10, 15]
    else [0, 0, 0]
    end
  end

  def respond_informe_pdf(filename, orientation: 'Portrait')
    respond_to do |format|
      format.html
      format.pdf do
        redirect_to url_for(params.permit!.merge(format: :html))
      end
    end
  end

  def render_registroclase_pdf
    render pdf: "registro_clase_#{@personastramite.id}",
           template: 'personastramites/registroclase',
           formats: [:html],
           layout: 'informes_registroclase_pdf',
           encoding: 'UTF-8',
           page_size: 'Letter',
           orientation: 'Portrait',
           margin: { top: 3, bottom: 3, left: 4, right: 4 },
           disposition: 'inline',
           print_media_type: true,
           disable_smart_shrinking: true
  end
end
