class UsersmodulosController < ApplicationController

  before_filter :require_user

  def index
    user   = User.find(params[:user_id])
    @usersmodulos = user.usersmodulos.all
  end

  def edit
    @usersmodulo  = Usersmodulo.find(params[:id], :include => "user")
    @user  = @usersmodulo.user
    respond_to do |format|
      format.js { render :action => "edit_usersmodulo" }
    end
  end

  def create
    @user  = User.find(params[:user_id])
    @usersmodulo = Usersmodulo.new(params[:usersmodulo])
    if @usersmodulo.valid?
      @user.usersmodulos << @usersmodulo
      @user.save
      @usersmodulo = Usersmodulo.new
    else
      flash[:warning] = "Se produjo un error al guardar el registro"
    end
    respond_to do |format|
      format.js { render :action => "usersmodulos" }
    end
  end

  def update
    @usersmodulo        = Usersmodulo.new
    usersmodulo         = Usersmodulo.find(params[:id])
    @user        = usersmodulo.user
    ok = usersmodulo.update_attributes(params[:usersmodulo])
    flash[:notice] = ok ? "Usuario asociado Correctamente." : "Se produjo un error al Asociar"
    respond_to do |format|
      format.js { render :action => "usersmodulos" }
    end
  end

  def destroy
    usersmodulo   = Usersmodulo.find(params[:id])
    @user  = usersmodulo.user
    @usersmodulo  = Usersmodulo.new
    usersmodulo.destroy
    respond_to do |format|
      format.js { render :action => "usersmodulos" }
    end
  end
end
