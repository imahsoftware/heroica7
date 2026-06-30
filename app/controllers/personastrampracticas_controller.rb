# frozen_string_literal: true

class PersonastrampracticasController < ApplicationController
  before_action :set_personastrampractica, only: [:edit, :update]
  before_action :set_personastramite_for_form, only: [:edit, :update, :create]

  layout 'informes'

  def edit
    respond_to do |format|
      format.html { render 'personastrampractica_form' }
      format.pdf  { render_practica_pdf }
    end
  end

  def create
    @personastrampractica = Personastrampractica.new(personastrampractica_params)
    @personastrampractica.user_id = is_admin
    if @personastrampractica.save
      flash[:notice] = 'Evaluación Creado con Exito.'
      redirect_to edit_personastrampractica_path(@personastrampractica)
    else
      render 'personastrampractica_form'
    end
  end

  def update
    @personastrampractica.user_id = is_admin
    if @personastrampractica.update(personastrampractica_params)
      flash[:notice] = 'Evaluación Actualizado con Exito.'
      redirect_to edit_personastrampractica_path(@personastrampractica)
    else
      Rails.logger.warn "personastrampractica #{@personastrampractica.id} update falló: #{@personastrampractica.errors.full_messages.join(', ')}"
      render 'personastrampractica_form', status: :unprocessable_entity
    end
  end

  def calcularvalor
    pvr0 = params[:pvr0].to_s
    pvr1 = params[:pvr1].to_s
    pvr2 = params[:pvr2].to_f
    dato = if pvr0 == 'inspeva'
             (20 * pvr2) / 100
           elsif %w[desteva compeva].include?(pvr0)
             (40 * pvr2) / 100
           end
    cal_prefix = { 'inspeva' => 'inspcal', 'desteva' => 'destcal', 'compeva' => 'compcal' }[pvr0]
    field_id = "personastrampractica_#{cal_prefix}_#{pvr1}"
    render json: { field_id: field_id, value: dato }
  end

  private

  def set_personastrampractica
    @personastrampractica = Personastrampractica.find(params[:id])
  end

  def set_personastramite_for_form
    return unless @personastrampractica&.personastramite_id

    @personastramite = Personastramite.find(@personastrampractica.personastramite_id)
  end

  def render_practica_pdf
    render pdf: "prueba_practica_moto_#{@personastrampractica.id}",
           template: 'personastrampracticas/personastrampractica_form',
           formats: [:html],
           layout: 'informes_practica_pdf',
           encoding: 'UTF-8',
           page_size: 'Letter',
           orientation: 'Portrait',
           margin: { top: 8, bottom: 8, left: 8, right: 8 },
           disposition: 'inline',
           print_media_type: true,
           disable_smart_shrinking: true
  end

  def personastrampractica_params
    params.require(:personastrampractica).permit!
  end
end
