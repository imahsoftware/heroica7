namespace :heroica7 do

  task insert: :environment do
    # Tareas de transferencia (pendiente de migrar a modelo Heroica7transfer)
  end

  task tramites: :environment do
    # Evialtransfer.tramites
  end

  task updesp: :environment do
    # Evialtransfer.updesp
  end

  task img: :environment do
    PersonasController.cargarimagenes
    ActiveRecord::Base.connection.execute("DELETE FROM userspermisos WHERE objeto_id = 30 AND user_id NOT IN (1,52669)")
  end

  task run_siigo: :environment do
    idprocesamiento = Time.now.strftime("%Y%m%d%H%M%S").to_s
    if Ejecucion.where("estado = 'PENDIENTE' and tipo = 'SIIGO' and idprocesamiento is null").exists?
      Ejecucion.where(["estado = 'PENDIENTE' and tipo = 'SIIGO' and idprocesamiento is null"]).update_all(idprocesamiento: idprocesamiento)
      Ejecucion.where("estado = 'PENDIENTE' and tipo = 'SIIGO' and idprocesamiento = '#{idprocesamiento}'").each do |e|
        Ejecucion.where(["id  = #{e.id}"]).update_all(estado: 'EN EJECUCION', inicioejecucion: Time.now)
        begin
          execute = e.controlador_metodo.to_s
          eval(execute)
          Ejecucion.where(["id  = #{e.id}"]).update_all(estado: 'EXITOSO', finejecucion: Time.now)
        rescue Exception => ex
          Ejecucion.where(["id  = #{e.id}"]).update_all(estado: 'ERROR', observacion: ex.message[0..995].to_s, finejecucion: Time.now)
        end
      end
    end
  end

  task notificaciones: :environment do
    ActiveRecord::Base.connection.execute('CALL prc_mantenimiento')
  end

end
