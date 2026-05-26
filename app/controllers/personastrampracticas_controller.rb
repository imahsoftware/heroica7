# frozen_string_literal: true

class PersonastrampracticasController < ApplicationController
  before_action :set_personastrampractica, only: [:edit, :update]

  layout 'informes'

  def edit
    render 'personastrampractica_form'
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
      render 'personastrampractica_form'
    end
  rescue StandardError
    redirect_to edit_personastrampractica_path(@personastrampractica)
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

  def personastrampractica_params
    params.require(:personastrampractica).permit!
  end
end
