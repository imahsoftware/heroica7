class Evcsms::SendsmsServices

  #Evcsms::SendsmsServices.new.send_sms_notificacion(@user.id, mensaje)

  def send_sms_datos_acceso(idRegistro, mensajeDescripcion)
    user = User.find(idRegistro)
    WsController.smscolombiared(user.celular.to_s,mensajeDescripcion.to_s)
    begin
      User.where(id: idRegistro).update_all(observaciones: '202 - SMS-Enviado al Users')
    rescue Exception => ex
      User.where(id: idRegistro).update_all(observaciones: '999 - ERROR-SMS-Enviado al Users: ' + ex.message[0..1000].to_s)
    end
  end

  def send_autorizacion(idRegistro)
    celular = Parametro.find(46).valor.to_s rescue nil
    msj = "Hola, hay una autorizacion de agendamiento pendiente. link para autorizacion http://app-evc.com/validac?a=#{idRegistro.to_s}".html_safe rescue nil
    WsController.smscolombiared(celular.to_s,msj.to_s)
    celular = Parametro.find(47).valor.to_s rescue nil
    msj = "Hola, hay una autorizacion de agendamiento pendiente. link para autorizacion http://app-evc.com/validac?a=#{idRegistro.to_s}".html_safe rescue nil
    WsController.smscolombiared(celular.to_s,msj.to_s)
    #uri = URI("https://masivos.colombiared.com.co/Api/get/send.php?username=ffernandez&password=Jeronimo2010&to=57#{celular.to_s}&text=#{msj}&from=TEST&coding=0&dlr-mask=8")
    #req = open(uri, {ssl_verify_mode: OpenSSL::SSL::VERIFY_NONE}) rescue nil
  end

  def send_sms_notificacion(nroCelular, mensajeDescripcion)
    WsController.smscolombiared(nroCelular.to_s,mensajeDescripcion.to_s)
  end

  def send_sms_alerta(nroCelulares, mensajeDescripcion)
    WsController.smscolombiaredmasivo(nroCelulares.to_s,mensajeDescripcion.to_s)
  end

end