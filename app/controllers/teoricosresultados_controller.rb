# frozen_string_literal: true

class TeoricosresultadosController < ApplicationController
  layout 'basico'

  def index
    # legacy had search/pagination; keep minimal for now
    @teoricosresultados = Teoricosresultado.all
  end

  def edit
    @teoricosresultado = Teoricosresultado.find(params[:id])
    render :teoricosresultado_form
  end

  def update
    @teoricosresultado = Teoricosresultado.find(params[:id])
    if @teoricosresultado.update(teoricosresultado_params)
      redirect_to edit_teoricosresultado_path(@teoricosresultado)
    else
      render :teoricosresultado_form
    end
  rescue StandardError
    redirect_to edit_teoricosresultado_path(@teoricosresultado)
  end

  def next
    @teoricosresultado = Teoricosresultado.where(teorico_id: params[:id], consecutivo: params[:consecutivo]).first
    redirect_to edit_teoricosresultado_path(@teoricosresultado)
  end

  def previous
    @teoricosresultado = Teoricosresultado.where(teorico_id: params[:id], consecutivo: params[:consecutivo]).first
    redirect_to edit_teoricosresultado_path(@teoricosresultado)
  end

  def marcar
    @teoricosresultado = Teoricosresultado.find(params[:id])
    @teoricosresultado.respuesta = params[:opc]
    @teoricosresultado.estado = Teoricosresultado.estadopregunta(@teoricosresultado.pregunta_id, params[:opc])
    @teoricosresultado.save
    redirect_to edit_teoricosresultado_path(@teoricosresultado)
  end

  def desmarcar
    @teoricosresultado = Teoricosresultado.find(params[:id])
    @teoricosresultado.respuesta = nil
    @teoricosresultado.estado = nil
    @teoricosresultado.save
    flash[:notice] = 'Opcion desmarcada con exito'
    redirect_to edit_teoricosresultado_path(@teoricosresultado)
  end

  def finalizar
    @teoricosresultado = Teoricosresultado.find(params[:id])
    @teorico = Teorico.find(@teoricosresultado.teorico_id)
    @teorico.correctas   = Teoricosresultado.where(teorico_id: @teoricosresultado.teorico_id, estado: 'C').count.to_i
    @teorico.incorrectas = Teoricosresultado.where(teorico_id: @teoricosresultado.teorico_id, estado: 'I').count.to_i
    @teorico.estado = (@teorico.correctas.to_i >= 38) ? 'APROBADO' : 'REPROBADO'
    @teorico.save
    flash[:notice] = 'Examen teorico finalizado con exito...'
    redirect_to teoricos_busqueda_path
  end

  private

  def teoricosresultado_params
    params.require(:teoricosresultado).permit!
  end
end

