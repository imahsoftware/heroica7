class UserspermisosController < ApplicationController

  before_filter :require_user

  def index
    user   = User.find(params[:user_id])
    @userspermisos = user.userspermisos.all
  end

  def edit
    @userspermiso  = Userspermiso.find(params[:id], :include => "user")
    @user  = @userspermiso.user
    respond_to do |format|
      format.js { render :action => "edit_userspermiso" }
    end
  end

  def create
    @user  = User.find(params[:user_id])
    @userspermiso = Userspermiso.new(params[:userspermiso])
    if @userspermiso.valid?
      @user.userspermisos << @userspermiso
      @user.save
      @userspermiso = Userspermiso.new
    else
      flash[:warning] = "Se produjo un error al guardar el registro"
    end
    respond_to do |format|
      format.js { render :action => "userspermisos" }
    end
  end

  def update
    @userspermiso        = Userspermiso.new
    userspermiso         = Userspermiso.find(params[:id])
    @user        = userspermiso.user
    ok = userspermiso.update_attributes(params[:userspermiso])
    flash[:notice] = ok ? "Usuario asociado Correctamente." : "Se produjo un error al Asociar"
    respond_to do |format|
      format.js { render :action => "userspermisos" }
    end
  end

  def destroy
    userspermiso   = Userspermiso.find(params[:id])
    @user  = userspermiso.user
    @userspermiso  = Userspermiso.new
    userspermiso.destroy
    respond_to do |format|
      format.js { render :action => "userspermisos" }
    end
  end
end
