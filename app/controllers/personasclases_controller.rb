# frozen_string_literal: true

class PersonasclasesController < ApplicationController
  before_action :set_persona
  before_action :set_personasclase, only: [:show, :edit, :update, :destroy]

  layout :set_layout

  # GET /personas/:persona_id/personasclases
  def index
    @personasclases = @persona.personasclases.all
  end

  # GET /personas/:persona_id/personasclases/:id  (JS)
  def show
    respond_to { |format| format.js }
  end

  # GET /personas/:persona_id/personasclases/new  (JS)
  def new
    @active_record  = Personasclase.find(params[:active_id]) if params[:active_id].present?
    @personasclase  = Personasclase.new
    respond_to { |format| format.js }
  end

  # GET /personas/:persona_id/personasclases/:id/edit  (JS)
  def edit
    @active_record = Personasclase.find(params[:active_id]) if params[:active_id].present?
    respond_to { |format| format.js }
  end

  # POST /personas/:persona_id/personasclases
  def create
    @personasclase          = Personasclase.new(personasclase_params)
    @personasclase.user_id  = is_admin
    respond_to do |format|
      if @personasclase.valid?
        @persona.personasclases << @personasclase
        @persona.save
        @personasclase = Personasclase.new
        flash[:notice] = t(:notice_crea_msj)
        format.js
      else
        flash[:notice] = 'Se produjo un error al guardar el registro'
        format.js { render 'layouts/errors', locals: { object: @personasclase } }
      end
    end
  end

  # PATCH/PUT /personas/:persona_id/personasclases/:id
  def update
    personasclase_edit = Personasclase.find(params[:id])
    personasclase_edit.user_actualiza = is_admin
    respond_to do |format|
      if personasclase_edit.update(personasclase_params)
        @personasclase = Personasclase.new
        flash[:notice] = t(:notice_actualiza_msj)
        format.js
      else
        format.js { render 'layouts/errors', locals: { object: personasclase_edit } }
      end
    end
  end

  # DELETE /personas/:persona_id/personasclases/:id
  def destroy
    @personasclase.destroy
    @personasclase = Personasclase.new
    flash['success'] = 'Eliminado con exito'
    respond_to { |format| format.js }
  end

  private

  def set_persona
    @persona = Persona.find(params[:persona_id])
  end

  def set_personasclase
    @personasclase = Personasclase.find(params[:id])
  end

  def personasclase_params
    params.require(:personasclase).permit!
  end

  def set_layout
    'application_personas'
  end
end
