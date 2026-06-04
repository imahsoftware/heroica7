# frozen_string_literal: true

class TeoricosController < ApplicationController
  before_action :set_persona, except: %i[busqueda index]
  before_action :set_teorico, only: [:show, :edit, :update, :destroy, :informe]

  layout :set_layout

  # GET /teoricos — pantalla búsqueda prueba teórica (legacy index)
  def index
    return redirect_to(edit_persona_path(@persona, etapa: 'D')) if params[:persona_id].present?
  end

  # GET /teoricos/busqueda  — búsqueda para iniciar prueba teórica
  def busqueda
    @persona_busqueda = Persona.find_by(identificacion: params[:buscarident])
    if @persona_busqueda&.id
      if Teorico.exists?(persona_id: @persona_busqueda.id, estado: 'PENDIENTE')
        @teorico = Teorico.where(persona_id: @persona_busqueda.id, estado: 'PENDIENTE')
                          .order(:id).first
        @teoricosresultados = Teoricosresultado.where(teorico_id: @teorico.id).order(:id).first
        redirect_to edit_teoricosresultado_path(@teoricosresultados)
      else
        flash[:warninglogin] = 'El usuario no tiene prueba programada'
        redirect_to teoricos_busqueda_path
      end
    else
      flash[:warninglogin] = 'La usuario no existe'
      redirect_to teoricos_busqueda_path
    end
  rescue StandardError
    flash[:warninglogin] = 'Debe digitar datos para la consulta'
    redirect_to teoricos_busqueda_path
  end

  # GET /personas/:persona_id/teoricos/:id  (JS)
  def show
    respond_to { |format| format.js }
  end

  # GET /personas/:persona_id/teoricos/new  (JS)
  def new
    @active_record = Teorico.find(params[:active_id]) if params[:active_id].present?
    @teorico       = Teorico.new
    respond_to { |format| format.js }
  end

  # GET /personas/:persona_id/teoricos/:id/edit  (JS)
  def edit
    @active_record = Teorico.find(params[:active_id]) if params[:active_id].present?
    respond_to { |format| format.js }
  end

  # GET /personas/:persona_id/teoricos/:id/informe
  def informe
    @teoricosresultados = Teoricosresultado.where(teorico_id: @teorico.id)
  end

  # POST /personas/:persona_id/teoricos
  def create
    @teorico          = Teorico.new(teorico_params)
    @teorico.user_id  = is_admin
    respond_to do |format|
      if @teorico.valid?
        @persona.teoricos << @teorico
        @persona.save
        @teorico = Teorico.new
        flash[:notice] = t(:notice_crea_msj)
        format.js
      else
        flash[:notice] = 'Se produjo un error al guardar el registro'
        format.js { render 'layouts/errors', locals: { object: @teorico } }
      end
    end
  end

  # PATCH/PUT /personas/:persona_id/teoricos/:id
  def update
    teorico_edit = Teorico.find(params[:id])
    teorico_edit.user_actualiza = is_admin
    respond_to do |format|
      if teorico_edit.update(teorico_params)
        @teorico = Teorico.new
        flash[:notice] = t(:notice_actualiza_msj)
        format.js
      else
        format.js { render 'layouts/errors', locals: { object: teorico_edit } }
      end
    end
  end

  # DELETE /personas/:persona_id/teoricos/:id
  def destroy
    @teorico.destroy
    @teorico = Teorico.new
    flash['success'] = 'Eliminado con exito'
    respond_to { |format| format.js }
  end

  private

  def set_persona
    @persona = Persona.find(params[:persona_id])
  end

  def set_teorico
    @teorico = Teorico.find(params[:id])
  end

  def teorico_params
    params.require(:teorico).permit!
  end

  def set_layout
    if %w[index busqueda].include?(action_name)
      'basico'
    elsif action_name == 'informe'
      'informes'
    else
      'application_personas'
    end
  end
end
