class Viaje < ActiveRecord::Base
  has_many :viajesrecibos
    belongs_to :tiposviaje
  validates_presence_of :tiposviaje_id, :identificacion, :nombre, :apellido

  def self.buscar(tour, id)
      cadena = ""
      if id.to_s != ""
        if cadena != ""
          cadena = cadena + ' and identificacion = '+ "'#{id}'"
        else
          cadena = cadena + ' identificacion = '+ "'#{id}'"
        end
      end
      if tour.to_s != ""
        if cadena != ""
          cadena = cadena + ' and tiposviaje_id = '+ "'#{tour}'"
        else
          cadena = cadena + ' tiposviaje_id  = '+ "'#{tour}'"
        end
      end
      if cadena != ""
        find(:all, :conditions => [cadena], :order => "created_at")
      else
        find(:all, :conditions => ['created_at = curdate()'], :order => "created_at")
      end
  end

end
