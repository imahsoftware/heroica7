class InstructoresController < ApplicationController
  before_action :set_instructor, only: [:show, :edit, :update, :destroy]

  layout :set_layout
  before_action :checkaccess

  def checkaccess
    return is_permit('instructores')
  end

  def index
    @q = Instructor.ransack(params[:q])
    @instructores = @q.result.paginate(page: params[:page], per_page: 15)
    respond_to do |format|
      format.html
    end
  end

  def show
    respond_to { |format| format.js }
  end

  def new
    @active_record = Instructor.find(params[:active_id]) if params[:active_id].present?
    @instructor = Instructor.new
    respond_to { |format| format.js }
  end

  def edit
    @active_record = Instructor.find(params[:active_id]) if params[:active_id].present?
    respond_to { |format| format.js }
  end

  def create
    @instructor = Instructor.new(instructor_params)
    respond_to do |format|
      if @instructor.save
        flash[:notice] = t(:notice_crea_msj)
        format.js
      else
        format.js { render 'layouts/errors', locals: { object: @instructor } }
      end
    end
  end

  def update
    respond_to do |format|
      if @instructor.update(instructor_params)
        flash[:notice] = t(:notice_actualiza_msj)
        format.js
      else
        format.js { render 'layouts/errors', locals: { object: @instructor } }
      end
    end
  end

  def destroy
    @instructor.destroy
    flash['success'] = 'Eliminado con éxito'
    respond_to { |format| format.js }
  end

  private

  def set_instructor
    @instructor = Instructor.find(params[:id])
  end

  def instructor_params
    params.require(:instructor).permit(
      :identificacion, :nombre,
      :nro_licencia, :fecha_exp_lic, :fecha_ven_lic,
      :nro_licenciai, :fecha_exp_lici, :fecha_ven_lici,
      :fecha_exp_cont, :fecha_ven_cont,
      :anno_evaluacion
    )
  end

  def set_layout
    'application_admin'
  end
end
