class Usersingreso < ActiveRecord::Base
  belongs_to :user

  def self.search(usersingreso, fchinicio)
      cadena = ""
      if usersingreso.user_id.to_s != ""
        if cadena != ""
          cadena = cadena + ' and user_id = ' + usersingreso.user_id.to_s
        else
          cadena = ' user_id = ' + usersingreso.user_id.to_s
        end
      end
      if fchinicio != ""
        if cadena != ""
          cadena = cadena + ' and fecha = ' + "'#{fchinicio}'"
        else
          cadena = ' fecha = ' + "'#{fchinicio}'"
        end
      end
      if cadena != ""
        find(:all, :conditions => [cadena], :order => "created_at")
      else
        find(:all, :conditions => ['created_at = curdate()'], :order => "userauditado_id, fecha_monitoreo")
      end
  end

  def dtipo
     if self.tipo == "B"
       return "SALIDA PARA BREAK"
     elsif self.tipo == "A"
       return "SALIDA PARA ALMUERZO"
     elsif self.tipo == "P"
       return "SALIDA PARA PAUSA"
     elsif self.tipo == "N"
       return "SALIDA PARA BAÑO"
     elsif self.tipo == "C"
       return "SALIDA PARA CITA MEDICA"
     elsif self.tipo == "T"
       return "SALIDA PARA CAMBIO DE TURNO"
     elsif self.tipo == "S"
       return "SALIDA OPERACION"
     elsif self.tipo == "E"
       return "ENTRADA"
     else
       return "-----"
     end
  end
end
