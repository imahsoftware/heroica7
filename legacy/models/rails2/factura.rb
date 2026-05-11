class Factura < ActiveRecord::Base
  belongs_to :user
  belongs_to :persona
  has_many :personastramites
  has_many :detallesfacturas
  has_many :abonos
  belongs_to :categoria
  belongs_to :tipostramite

  def destado
    if self.estado == 'P'
      return 'PENDIENTE'
    elsif self.estado == 'A'
      return 'ANULADO'
    elsif self.estado == 'C'
      return 'CANCELADO'
    end
  end

  def self.buscar(buscarident, buscarnombre, buscarfactura, buscarabono)
      cadena = ""
      if buscarident != ""
        if cadena != ""
          cadena = cadena + ' and persona_id in (select id from personas where identificacion  = ' + "'#{buscarident.to_s}'"+')'
        else
          cadena = ' persona_id in (select id from personas where identificacion  = ' + "'#{buscarident.to_s}'"+')'
        end
      end
      if buscarnombre != ""
        s = buscarnombre.upcase
        if cadena != ""
          cadena = cadena + ' and persona_id in (select id from personas where autobuscar like ' + "'%%#{s.to_s}%%'"+ ')'
        else
          cadena = ' persona_id in (select id from personas where autobuscar like ' + "'%%#{s.to_s}%%'"+ ')'
        end
      end
      if buscarfactura != ""
        if cadena != ""
          cadena = cadena + ' and nro_factura = '+ "'#{buscarfactura.to_s}'"
        else
          cadena = ' nro_factura like '+ "'#{buscarfactura.to_s}'"
        end
      end
      if buscarabono != ""
        if cadena != ""
          cadena = cadena + ' and id in (select factura_id from abonos where nro_abono = '+ "'#{buscarabono.to_s}'"+')'
        else
          cadena = ' id in (select factura_id from abonos where nro_abono = '+ "'#{buscarabono.to_s}'"+')'
        end
      end
      if cadena != ""
        find(:all, :conditions => [cadena], :order => 'nro_factura')
      else
        find(:all, :conditions => ['created_at = curdate()'], :order => 'nro_factura')
      end
  end

end
