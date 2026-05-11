class Egreso < ActiveRecord::Base
  belongs_to :user
  belongs_to :proveedor
  has_many :egresosimagenes

  validates_presence_of :nro_egreso, :fecha, :valor, :proveedor_id

  def self.search (egreso, fchinicial, fchfinal)
      cadena = ""
      if egreso.nro_egreso != ""
        if cadena != ""
          cadena = cadena + ' and nro_egreso = ' + "'#{egreso.nro_egreso.to_s}'"
        else
          cadena = ' nro_egreso = ' + "'#{egreso.nro_egreso.to_s}'"
        end
      end
      if egreso.observacion.to_s != ""
        s = egreso.observacion.upcase
        if cadena != ""
          cadena = cadena + ' and upper(observacion) like '+ "'%%#{s.to_s}%%'"
        else
          cadena = ' upper(observacion) like '+ "'%%#{s.to_s}%%'"
        end
      end
      if egreso.proveedor_id.to_s != ""
        if cadena != ""
          cadena = cadena + ' and proveedor_id = ' + "'#{egreso.proveedor_id.to_s}'"
        else
          cadena = ' proveedor_id = ' + "'#{egreso.proveedor_id.to_s}'"
        end
      end
      if fchinicial.to_s != "" and fchfinal.to_s != ""
        if cadena != ""
          cadena = cadena + ' and fecha between ' + "'#{fchinicial.to_s}'" + ' and ' + "'#{fchfinal.to_s}'"
        else
          cadena = ' fecha between ' + "'#{fchinicial.to_s}'" + ' and ' + "'#{fchfinal.to_s}'"
        end
      end
      if cadena != ""
        find(:all, :conditions => [cadena], :order => "created_at")
      else
        find(:all, :conditions => ['trunc(created_at) = trunc(sysdate)'], :order => "created_at")
      end
  end

end
