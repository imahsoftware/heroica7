# frozen_string_literal: true

class PersonastramiteshorasController < ApplicationController
  before_action :find_personastramite, except: [:create2]
  before_action :find_personastramiteshora, only: [:show, :edit, :update, :destroy]

  layout :set_layout

  # GET /personastramiteshoras/hora?personastramite_id=X
  def hora
    @personastramiteshoras = @personastramite.personastramiteshoras.all
    @personastramiteshora  = Personastramiteshora.new
  end

  # GET /personastramiteshoras
  def index
    @personastramiteshoras = @personastramite.personastramiteshoras.all
  end

  # GET /personastramiteshoras/:id
  def show
  end

  # GET /personastramiteshoras/new?personastramite_id=X
  def new
    @personastramiteshora = Personastramiteshora.new
  end

  # GET /personastramiteshoras/new2?personastramite_id=X
  def new2
    @personastramiteshora = Personastramiteshora.new
    @personastramiteshora.personastramite_id = params[:personastramite_id]
  end

  # GET /personastramiteshoras/:id/edit
  def edit
  end

  # POST /personastramiteshoras
  def create
    @personastramiteshora = Personastramiteshora.new(personastramiteshora_params)
    @categoria = Categoria.find(@personastramite.categoria_id)

    sumtaller    = Personastramiteshora.where(personastramite_id: @personastramite.id).sum(:taller)
    sumpracticas = Personastramiteshora.where(personastramite_id: @personastramite.id).sum(:practicas)
    sumteoricas  = Personastramiteshora.where(personastramite_id: @personastramite.id).sum(:teoricas)

    tottaller    = sumtaller    + params[:personastramiteshora][:taller].to_i
    totpracticas = sumpracticas + params[:personastramiteshora][:practicas].to_i
    totteoricas  = sumteoricas  + params[:personastramiteshora][:teoricas].to_i

    if tottaller > @categoria.taller.to_i
      flash[:notice] = "La cantidad de Horas de Taller (#{tottaller}) para la categoria seleccionada no puede ser superior a #{@categoria.taller}"
      render :new and return
    elsif totpracticas > @categoria.practicas.to_i
      flash[:notice] = "La cantidad de Horas de Practicas (#{totpracticas}) para la categoria seleccionada no puede ser superior a #{@categoria.practicas}"
      render :new and return
    elsif totteoricas > @categoria.teoricas.to_i
      flash[:notice] = "La cantidad de Horas de Teoricas (#{totteoricas}) para la categoria seleccionada no puede ser superior a #{@categoria.teoricas}"
      render :new and return
    end

    @personastramiteshora.personastramite_id = @personastramite.id
    @personastramiteshora.user_id = is_admin

    if @personastramiteshora.save
      flash[:notice] = 'Registro de horas finalizado con exito.'
      redirect_to hora_personastramiteshoras_path(personastramite_id: @personastramite.id)
    else
      render :new
    end
  end

  # POST /personastramiteshoras/create2
  def create2
    @personastramiteshora = Personastramiteshora.new(personastramiteshora_params)
    @personastramite      = Personastramite.find(@personastramiteshora.personastramite_id)
    @categoria            = Categoria.find(@personastramite.categoria_id)

    sumtaller    = Personastramiteshora.where(personastramite_id: @personastramite.id).sum(:taller)
    sumpracticas = Personastramiteshora.where(personastramite_id: @personastramite.id).sum(:practicas)
    sumteoricas  = Personastramiteshora.where(personastramite_id: @personastramite.id).sum(:teoricas)

    tottaller    = sumtaller    + params[:personastramiteshora][:taller].to_i
    totpracticas = sumpracticas + params[:personastramiteshora][:practicas].to_i
    totteoricas  = sumteoricas  + params[:personastramiteshora][:teoricas].to_i

    if tottaller > @categoria.taller.to_i
      flash[:notice] = "La cantidad de Horas de Taller (#{tottaller}) no puede ser superior a #{@categoria.taller}"
      render :new2 and return
    elsif totpracticas > @categoria.practicas.to_i
      flash[:notice] = "La cantidad de Horas de Practicas (#{totpracticas}) no puede ser superior a #{@categoria.practicas}"
      render :new2 and return
    elsif totteoricas > @categoria.teoricas.to_i
      flash[:notice] = "La cantidad de Horas de Teoricas (#{totteoricas}) no puede ser superior a #{@categoria.teoricas}"
      render :new2 and return
    end

    @personastramiteshora.user_id = is_admin

    if @personastramiteshora.save
      flash[:notice] = 'Registro de horas finalizado con exito.'
      render :create2
    else
      render :new2
    end
  end

  # PATCH /personastramiteshoras/:id
  def update
    @personastramiteshora.user_actualiza = is_admin
    if @personastramiteshora.update(personastramiteshora_params)
      redirect_to hora_personastramiteshoras_path(personastramite_id: @personastramite.id)
    else
      render :edit
    end
  end

  # GET /personastramiteshoras/update2
  def update2
    @personastramiteshora = Personastramiteshora.find(params[:id])
    @personastramiteshora.user_actualiza = is_admin
    if @personastramiteshora.update(personastramiteshora_params)
      redirect_to hora_personastramiteshoras_path(personastramite_id: @personastramite.id)
    else
      render :edit
    end
  end

  # DELETE /personastramiteshoras/:id
  def destroy
    @personastramiteshora.destroy
    redirect_to hora_personastramiteshoras_path(personastramite_id: @personastramite.id)
  end

  private

  def find_personastramite
    @personastramite = Personastramite.find(params[:personastramite_id])
  end

  def find_personastramiteshora
    @personastramiteshora = Personastramiteshora.find(params[:id])
  end

  def personastramiteshora_params
    params.require(:personastramiteshora).permit!
  end

  def set_layout
    %w[create2 new2].include?(action_name) ? 'basico' : 'application'
  end
end
