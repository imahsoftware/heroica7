class UsersController < ApplicationController

  before_filter :require_user

  def index
    @users = User.search(params[:search], params[:page])
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @users }
    end
  end
  
  def new
    @user = User.new
  end

  def create
    @user = User.new(params[:user])
    if @user.save
      redirect_to users_path
    else
      render :action => :new
    end
  end

  def show
    @user = User.find(params[:id])
    @usersmodulos = Usersmodulos.find_by_user_id(@user.id)
    @userspermisos = Userspermisos.find_by_user_id(@user.id)
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @user }
    end
  end

  def edit
    @user = User.find(params[:id])
    @usersmodulo = Usersmodulo.new
    @userspermiso = Userspermiso.new
    respond_to do |format|
      format.html { render :action => "user_form" }
    end
  end
  
  def editpass
    @user = User.find(params[:id])
    respond_to do |format|
      format.html { render :action => "editpass" }
    end
  end

  def updatepass
    @user = User.find(params[:id])
    if @user.update_attributes(params[:user])
      flash[:notice] = "Contraseña Actualizada Correctamente."
      redirect_to menus_path
    else
      render :action => "editpass"
    end
  end

  def update
    @user = User.find(params[:id])
    if @user.update_attributes(params[:user])
      flash[:notice] = "Perfil actualizado correctamente."
      if (is_admin == 1)
        redirect_to edit_user_path(@user)
      else
        redirect_to menus_path
      end
    else
      @usersmodulo = Usersmodulo.new
      @userspermiso = Userspermiso.new
      render :action => "user_form"
    end
    rescue
    redirect_to edit_user_path(@user)
  end
  

end
