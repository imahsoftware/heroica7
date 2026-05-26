# frozen_string_literal: true

class PersonastrapracticasController < ApplicationController
  before_action :set_personastrapractica, only: [:edit, :update]

  layout 'informes'

  def edit
    render 'personastrapractica_form'
  end

  def create
    @personastrapractica = Personastrapractica.new(personastrapractica_params)
    @personastrapractica.user_id = is_admin
    if @personastrapractica.save
      flash[:notice] = 'Evaluación Creado con Exito.'
      redirect_to edit_personastrapractica_path(@personastrapractica)
    else
      render 'personastrapractica_form'
    end
  end

  def update
    @personastrapractica.user_id = is_admin
    if @personastrapractica.update(personastrapractica_params)
      flash[:notice] = 'Evaluación Actualizado con Exito.'
      redirect_to edit_personastrapractica_path(@personastrapractica)
    else
      render 'personastrapractica_form'
    end
  rescue StandardError
    redirect_to edit_personastrapractica_path(@personastrapractica)
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
    field_id = "personastrapractica_#{cal_prefix}_#{pvr1}"
    render json: { field_id: field_id, value: dato }
  end

  private

  def set_personastrapractica
    @personastrapractica = Personastrapractica.find(params[:id])
  end

  def personastrapractica_params
    params.require(:personastrapractica).permit!
  end
end
