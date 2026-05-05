class UsersreportesController < ApplicationController
  before_action :set_usersreporte, only: [:show, :edit, :update, :destroy]

  def show
    @user = User.find(params[:user_id])
    @usersreporte = Usersreporte.find(params[:id]) if params[:id]
    respond_to { |format| format.js }
  end

  def new
    @active_record = Usersreporte.find(params[:active_id]) if params[:active_id].present?
    @user = User.find(params[:user_id])
    @usersreporte = Usersreporte.new
    respond_to { |format| format.js }
  end

  def edit
    @active_record = Usersreporte.find(params[:active_id]) if params[:active_id].present?
    @usersreporte = Usersreporte.find(params[:id])
    @user = @usersreporte.user
    respond_to { |format| format.js }
  end

  def create
    @reportes = params[:usersreporte][:reporte_id].reject { |c| c.empty? }
    i = 0
    for i in 0..@reportes.count-1
      @user  = User.find(params[:user_id])
      @usersreporte = Usersreporte.new(usersreporte_params)
      @usersreporte.reporte_id = @reportes[i]
      @usersreporte.user_id = @user.id
      respond_to do |format|
        if @usersreporte.save
          format.js
        else
          format.js { render 'layouts/errors', locals: { object: @usersreporte } }
        end
      end
    end
  end

  def update
    @usersreporte = Usersreporte.find(params[:id])
    @user = @usersreporte.user
    respond_to do |format|
      if @usersreporte.update(usersreporte_params)
        flash[:notice] = "#{t :notice_actualiza_msj}"
        format.js
      else
        format.js { render 'layouts/errors', locals: { object: @usersreporte } }
      end
    end
  end

  def destroy
    @usersreporte.destroy
    flash['success'] = 'Eliminado correctamente'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_usersreporte
      @user = User.find(params[:user_id])
      @usersreporte = Usersreporte.find(params[:id]) if params[:id]
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def usersreporte_params
      params.require(:usersreporte).permit!
    end
end
