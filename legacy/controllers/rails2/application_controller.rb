class ApplicationController < ActionController::Base
#  helper :all
#  protect_from_forgery
  helper :all
  helper_method :current_user_session, :current_user
  filter_parameter_logging :password, :password_confirmation
  #before_filter :my_filter
  include ActionView::Helpers::NumberHelper

  private
    def current_user_session
      return @current_user_session if defined?(@current_user_session)
      @current_user_session = UserSession.find
    end

    def current_user
      return @current_user if defined?(@current_user)
      @current_user = current_user_session && current_user_session.record
      valor = current_user.id rescue nil
      if valor
        @usersmodulos = Usersmodulo.find_all_by_user_id(is_admin, :order => "modulo_id")
      else
        flash[:notice] = "Usted debe iniciar sesión antes de Acceder al Sistema."
        redirect_to new_user_session_url
      end
    end

    def require_user
      if Rails.env.production?
        if current_user.id.to_s == "4"
          flash[:notice] = "Usted debe iniciar sesión antes de Acceder al Sistema.w---"
          redirect_back_or_default root_path
        end
      end
      unless current_user
        store_location
        #flash[:notice] = "Usted debe iniciar sesión antes de Acceder al Sistema."+current_user.to_s
        redirect_to new_user_session_url
        return false
      end
    end

    def require_no_user
      if current_user
        store_location
        #flash[:notice] = "Usted debe iniciar sesión antes de Acceder al Sistema."
        redirect_to account_url
        return false
      end
    end

    def store_location
      session[:return_to] = request.request_uri
    end

    def redirect_back_or_default(default)
      redirect_to(session[:return_to] || default)
      session[:return_to] = nil
    end

    helper_method :is_admin
    def is_admin
      return current_user.id
   end

   helper_method :nameday
   def nameday(dia)
     day_names = ["Domingo", "Lunes", "Martes", "Miercoles", "Jueves", "Viernes", "Sabado"]
     return day_names[dia]
   end

   helper_method :namemonth
   def namemonth(mes)
     month_names = ["","Enero","Febrero", "Marzo", "Abril", "Mayo", "Junio", "Julio", "Agosto", "Setiembre", "Octubre", "Noviembre", "Diciembre"]
     return month_names[mes]
   end

   helper_method :namedate
   def namedate(fecha)
     day_names = ["Domingo", "Lunes", "Martes", "Miercoles", "Jueves", "Viernes", "Sabado"]
     month_names = ["","Enero","Febrero", "Marzo", "Abril", "Mayo", "Junio", "Julio", "Agosto", "Setiembre", "Octubre", "Noviembre", "Diciembre"]
     dia = fecha.strftime("%w").to_i
     ndia = day_names[dia]
     mes = fecha.strftime("%m").to_i
     nmes = month_names[mes]
     fchcompleta = ndia + ' ' + fecha.strftime("%d") + ' de ' + nmes + ' del ' + fecha.strftime("%Y")
     return fchcompleta
   end

   helper_method :is_usuario
   def is_usuario
       return current_user.nombre
   end

   helper_method :permiso
   def permiso(objeto, evento) #Evento debe ser A:Actualiza, E:Elimina, C:Crea
     objetoid = Objeto.find_by_descripcion(objeto)
     if objetoid.to_s != ""
       userspermisos = Userspermiso.find(:all, :conditions =>['user_id = ? and objeto_id = ?', is_admin, objetoid])
       userspermisos.each do |data|
       if evento == "A"
         return data.actualiza
       elsif evento == "E"
         return data.elimina
       elsif evento == "C"
         return data.crea
       end
     end
     end
   end

   helper_method :campohabilitado
   def campohabilitado(cliente, nombrecampo)
     campo = Campo.find_by_campo_tabla(nombrecampo)
     if cliente.to_s == "1"
       clientescampo = Clientescampo.find_by_cliente_id_and_campo_id(cliente,campo.id)
       if clientescampo.valido.to_s == "S"
         return clientescampo.valido
       end
     elsif cliente.to_s == "2"
       bancolombiascampo = Bancolombiascampo.find_by_cliente_id_and_campo_id(cliente,campo.id)
       if bancolombiascampo.valido.to_s == "S"
         return bancolombiascampo.valido
       end
     end
   end

   helper_method :camponumerico
   def camponumerico(campo)
     campo1 = campo.to_i
     if campo1 == 0
       campo1 = campo
     else
       campo1 = number_to_currency( campo.to_i, :precision => 0, :unit=>"", :delimiter =>".")
     end
     return campo1
   end

   helper_method :facturacero
   def facturacero(campo)
     @facturas = Factura.find_by_sql("select lpad(#{campo},8,'0') fact from dual")
     @facturas.each do |factura|
       return factura.fact
     end
   end

   helper_method :fechaprog
   def fechaprog(fechainicial, dias)
     if fechainicial.to_s != "" and dias.to_s != ""
       fechawork = fechainicial.to_time
       minutosmas = dias.to_i * 86400
       fechaprog = (fechawork + minutosmas.to_i)
       cantidad = Festivo.count(:conditions =>['fecha between ? and ?', fechawork, fechaprog])
       if cantidad > 0
         minutosadd = cantidad.to_i * 86400
         fechaprogramacion = fechawork + minutosmas.to_i + minutosadd.to_i
         fecha = fechaprogramacion.strftime("%Y-%m-%d")
         cantidad1 = Festivo.count(:conditions =>['fecha = ?', fecha])
         while cantidad1.to_i > 0
           fechaprogramacion = fechaprogramacion + 86400
           fecha = fechaprogramacion.strftime("%Y-%m-%d")
           cantidad1 = Festivo.count(:conditions =>['fecha = ?', fecha])
         end
       else
         fechaprogramacion = fechaprog
         fecha = fechaprog.strftime("%Y-%m-%d")
         cantidad1 = Festivo.count(:conditions =>['fecha = ?', fecha])
         while cantidad1.to_i > 0
           fechaprogramacion = fechaprogramacion + 86400
           fecha = fechaprogramacion.strftime("%Y-%m-%d")
           cantidad1 = Festivo.count(:conditions =>['fecha = ?', fecha])
         end
       end
     end
     return fecha
   end

#  protect_from_forgery
#  layout :detect_browser
#
#  private
#  MOBILE_BROWSERS = ["android", "ipod", "opera mini", "blackberry", "palm","hiptop","avantgo","plucker", "xiino","blazer","elaine", "windows ce; ppc;", "windows ce; smartphone;","windows ce; iemobile", "up.browser","up.link","mmp","symbian","smartphone", "midp","wap","vodafone","o2","pocket","kindle", "mobile","pda","psp","treo"]
#
#  def detect_browser
#    layout = selected_layout
#    return layout if layout
#    agent = request.headers["HTTP_USER_AGENT"].downcase
#    MOBILE_BROWSERS.each do |m|
#      return "mobile_application" if agent.match(m)
#    end
#    return "application"
#  end
#
#  def selected_layout
#    session.inspect # force session load
#    if session.has_key? "layout"
#      return (session["layout"] == "mobile") ?
#        "mobile_application" : "application"
#    end
#    return nil
#  end

   helper_method :is_factura
   def is_factura
     nrofactura = 0
     @facturas = Factura.find_by_sql("select max(nro_factura) nro from facturas")
     @facturas.each do |factura|
       nrofactura = factura.nro
     end
     return nrofactura.to_i+1
   end

   helper_method :is_liq
   def is_liq
     nroliq = 0
     @abonos = Abono.find_by_sql("select max(cast(nro_abono as signed)) nro from abonos")
     @abonos.each do |abono|
       nroliq = abono.nro
     end
     return nroliq.to_i+1
   end

   helper_method :fechamenos
   def fechamenos(fechasolicitud, dias)
     if fechasolicitud.to_s != "" and dias.to_i > 0
       fechawork = fechasolicitud.to_time
       minutosmas = dias.to_i * 86400
       fechaprog = (fechawork - minutosmas.to_i)
       fecha = fechaprog.strftime("%Y-%m-%d")
     end
     return fecha
   end

helper_method :descmes
   def descmes(mes)
     if mes.to_s == '01'
       return 'ENERO'
     elsif mes.to_s == '02'
       return 'FEBRERO'
     elsif mes.to_s == '03'
       return 'MARZO'
     elsif mes.to_s == '04'
       return 'ABRIL'
     elsif mes.to_s == '05'
       return 'MAYO'
     elsif mes.to_s == '06'
       return 'JUNIO'
     elsif mes.to_s == '07'
       return 'JULIO'
     elsif mes.to_s == '08'
       return 'AGOSTO'
     elsif mes.to_s == '09'
       return 'SEPTIEMBRE'
     elsif mes.to_s == '10'
       return 'OCTUBRE'
     elsif mes.to_s == '11'
       return 'NOVIEMBRE'
     elsif mes.to_s == '12'
       return 'DICIEMBRE'
     else
       return '------'
     end
   end

   helper_method :camponumerico
   def camponumerico(campo)
     campo1 = campo.to_i
     if campo1 == 0
       campo1 = campo
     else
       campo1 = number_to_currency( campo, :precision => 2, :unit=>"", :delimiter =>".")
       #campo1 = number_to_currency( campo.to_i, :precision => 0, :unit=>"", :delimiter =>".")
     end
     return campo1
   end
end
