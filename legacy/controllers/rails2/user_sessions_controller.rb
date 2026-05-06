class UserSessionsController < ApplicationController

  layout 'basico'

  def new
    @user_session = UserSession.new
  end

  def create
    @user_session = UserSession.new(params[:user_session])
    if @user_session.save
      tim = Time.now
      flash[:notice] = "Has Iniciado Sesión Correctamente... " + tim.strftime("%m/%d/%Y %I:%M:%S")
      u = Usersingreso.new
      t = @user_session.try(:record)
      u.tipo= "E"
      u.user_id = t.id
      u.fecha = Time.now
      u.save
      redirect_to menus_path
    else
      flash[:warninglogin] = "Problemas para iniciar Sesión. Verifique Usuario y Contraseña."
      render :action => :new
    end
  end

  def destroy
    tim = Time.now
    t = current_user_session.record
    u = Usersingreso.new
    u.tipo= "S"
    u.user_id = t.id
    u.fecha = Time.now
    u.save
    current_user_session.destroy
    flash[:notice] = "Has Cerrado Sesión Correctamente... " + tim.strftime("%m/%d/%Y %I:%M:%S")
    redirect_back_or_default new_user_session_url
  end

  def borrar
    valor1 = params[:var1]
    tim = Time.now
    t = current_user_session.record
    u = Usersingreso.new
    u.tipo= valor1.to_s
    u.user_id = t.id
    u.fecha = Time.now
    u.save
    current_user_session.destroy
    flash[:notice] = "Has Cerrado Sesión Correctamente... " + tim.strftime("%m/%d/%Y %I:%M:%S")
    redirect_back_or_default new_user_session_url
  end

#  def create
#    @user_session = UserSession.new(params[:user_session])
#    if @user_session.save
#      flash[:notice] = "Has Iniciado Sesión Correctamente."
#      redirect_to menus_path
#    else
#      render :action => :new
#    end
#  end
#
#  def destroy
#    current_user_session.destroy
#    flash[:notice] = "Has Cerrado Sesión Correctamente"
#    redirect_back_or_default new_user_session_url
#  end
end
