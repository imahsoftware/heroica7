# frozen_string_literal: true

class EmpleadosController < ApplicationController
  before_action :set_empleado, only: [:show, :edit, :update, :destroy]

  layout :set_layout
  before_action :checkaccess

  def checkaccess
    return is_permit('empleados')
  end

  # GET /empleados
  def index
    @q = Empleado.ransack(params[:q])
    @empleados = @q.result.paginate(page: params[:page], per_page: 10)
    respond_to do |format|
      format.html
    end
  end

  # GET /empleados/:id  (JS)
  def show
    respond_to { |format| format.js }
  end

  # GET /empleados/new  (JS)
  def new
    @active_record = Empleado.find(params[:active_id]) if params[:active_id].present?
    @empleado = Empleado.new
    respond_to { |format| format.js }
  end

  # GET /empleados/:id/edit  (JS)
  def edit
    @active_record = Empleado.find(params[:active_id]) if params[:active_id].present?
    respond_to { |format| format.js }
  end

  # POST /empleados
  def create
    @empleado = Empleado.new(empleado_params)
    respond_to do |format|
      if @empleado.save
        flash[:notice] = "#{t :notice_crea_msj}"
        format.js
      else
        format.js { render 'layouts/errors', locals: { object: @empleado } }
      end
    end
  end

  # PATCH/PUT /empleados/:id
  def update
    respond_to do |format|
      if @empleado.update(empleado_params)
        flash[:notice] = "#{t :notice_actualiza_msj}"
        format.js
      else
        format.js { render 'layouts/errors', locals: { object: @empleado } }
      end
    end
  end

  # DELETE /empleados/:id
  def destroy
    @empleado.destroy
    flash['success'] = 'Eliminado con exito'
  end

  private

  def set_empleado
    @empleado = Empleado.find(params[:id])
  end

  def empleado_params
    params.require(:empleado).permit!
  end

  def set_layout
    'application'
  end
end
