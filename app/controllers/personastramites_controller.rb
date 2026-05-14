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
    @personastramite          = Personastramite.new(personastramite_params)
    @personastramite.user_id  = is_admin
    respond_to do |format|
      if @personastramite.valid?
        @persona.personastramites << @personastramite
        @persona.save
        @personastramite = Personastramite.new
        flash[:notice] = t(:notice_crea_msj)
        format.js
      else
        flash[:notice] = 'Se produjo un error al guardar el registro'
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
        @personastramite = Personastramite.new
        flash[:notice] = t(:notice_actualiza_msj)
        format.js
      else
        format.js { render 'layouts/errors', locals: { object: @personastramite_edit } }
      end
    end
  end

  # DELETE /personas/:persona_id/personastramites/:id
  def destroy
    @personastramite.respaldo(is_admin)
    @personastramite.destroy
    @personastramite = Personastramite.new
    flash['success'] = 'Eliminado con exito'
    respond_to { |format| format.js }
  end

  # ── Acciones especiales del legacy ────────────────────────────────────────

  # GET /personas/:persona_id/personastramites/:id/registroclase
  def registroclase
  end

  # GET /personas/:persona_id/personastramites/:id/registrosolicitud
  def registrosolicitud
  end

  # GET /personas/:persona_id/personastramites/:id/diploma
  def diploma
    @nombre = params[:nombredip]
  end

  # GET /personas/:persona_id/personastramites/:id/acuerdocomercial
  def acuerdocomercial
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
            Personastrapractica.create!(
              personastramite_id: @personastramite.id,
              user_id:            is_admin
            )
          end
    redirect_to edit_personastrapractica_path(pra.id)
  end

  # GET /personas/:persona_id/personastramites/:id/practicam
  def practicam
    pra = if Personastrampractica.exists?(personastramite_id: @personastramite.id)
            Personastrampractica.find_by(personastramite_id: @personastramite.id)
          else
            Personastrampractica.create!(
              personastramite_id: @personastramite.id,
              user_id:            is_admin
            )
          end
    redirect_to edit_personastrampractica_path(pra.id)
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
    elsif %w[registroclase registrosolicitud].include?(action_name)
      'informes'
    elsif %w[diploma acuerdocomercial].include?(action_name)
      'cartas'
    else
      'application_personas'
    end
  end
end
