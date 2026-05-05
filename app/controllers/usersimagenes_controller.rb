class UsersimagenesController < ApplicationController
  before_action :set_usersimagen, only: [:show, :destroy]

  def index
    @usersimagenes = Usersimagen.all
  end

  def show
    respond_to { |format| format.js }
  end

  def new
    @active_record = Usersimagen.find(params[:active_id]) if params[:active_id].present?
    @user = User.find(params[:user_id])
    @usersimagen = Usersimagen.new
    respond_to { |format| format.js }
  end

  def edit
    @active_record = Usersimagen.find(params[:active_id]) if params[:active_id].present?
    @usersimagen = Usersimagen.find(params[:id])
    @user = @usersimagen.user
    respond_to { |format| format.js }
  end

  def create
    @user  = User.find(params[:user_id])
    @usersimagen = Usersimagen.new(usersimagen_params)
    @usersimagen.user_id = @user.id
    respond_to do |format|
      if @usersimagen.save
        flash[:notice] = "#{t :notice_crea_msj}"
        format.js
      else
        format.js { render 'layouts/errors', locals: { object: @usersimagen } }
      end
    end
  end

  def update
    @usersimagen = Usersimagen.find(params[:id])
    @user = @usersimagen.user
    respond_to do |format|
      if @usersimagen.update(usersimagen_params)
        flash[:notice] = "#{t :notice_actualiza_msj}"
        format.js
      else
        format.js { render 'layouts/errors', locals: { object: @usersimagen } }
      end
    end
  end

  def destroy
    flash['success'] = 'Eliminado correctamente'
    @usersimagen.destroy
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_usersimagen
    @user = User.find(params[:user_id])
    @usersimagen = Usersimagen.find(params[:id]) if params[:id]
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def usersimagen_params
    params.require(:usersimagen).permit!
  end
end
