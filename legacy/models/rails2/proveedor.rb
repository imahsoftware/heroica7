class Proveedor < ActiveRecord::Base
  belongs_to :user
  has_many :egresos

  validates_presence_of :documento, :identificacion, :direccion, :telefonos, :email

  def before_save
    nom = []
    if self.identificacion.nil? == false
      nom << self.identificacion.to_s
    end
    if self.primer_nombre.nil? == false
      nom << self.primer_nombre.to_s
    end
    if self.segundo_nombre.nil? == false
      nom << self.segundo_nombre.to_s
    end
    if self.primer_apellido.nil? == false
      nom << self.primer_apellido.to_s
    end
    if self.segundo_apellido.nil? == false
      nom << self.segundo_apellido.to_s
    end
    if self.razon_social.nil? == false
      nom << self.razon_social.to_s
    end
    if nom.size > 0
      sqlDatos = ""
      sqlDatos << "#{nom.join(" ")}"
      self.autobuscar = sqlDatos
    end
  end

=begin
  def self.search (nroradicado, identificacion, identificacionb, correspondenciasremitenteid, fchelainicial, fchelafinal, fchrecinicial, fchrecfinal, dependenciaid, correspondenciasclase_id, asunto, observacion, nro_externo, empresa, empresar, recibidoemail, clase, page)
    cadena = []
    if nroradicado.to_s != ""
      cadena << ' nro_radicado = ' + "'#{nroradicado.strip}'"
    end
    if nro_externo.to_s != ""
      cadena << ' numero_externo = ' + "'#{nro_externo.strip}'"
    end
    if identificacion.to_s != ""
      cadena << ' persona_id in (select id from personas where identificacion = ' + "'#{identificacion.strip}'" + ')'
    end
    if identificacionb.to_s != ""
      cadena << ' benevivienda_id in (select id from beneviviendas where identificacion is not null and identificacion = ' + "'#{identificacionb.strip}'" + ')'
    end
    if correspondenciasremitenteid.to_s != ""
      cadena << ' correspondenciasremitente_id = ' + "'#{correspondenciasremitenteid}'"
    end
    if fchelainicial.to_s != "" and fchelafinal.to_s != ""
      cadena << ' fecha_elaboracion between ' + "'#{fchelainicial}'" + ' and ' + "'#{fchelafinal}'"
    end
    if fchrecinicial.to_s != "" and fchrecfinal.to_s != ""
      cadena << ' trunc(created_at) between ' + "'#{fchrecinicial}'" + ' and ' + "'#{fchrecfinal}'"
    end
    if dependenciaid.to_s != ""
      cadena << ' dependencia_id = ' + "'#{dependenciaid}'"
    end
    if correspondenciasclase_id.to_s != ""
      cadena << ' correspondenciasclase_id = ' + "'#{correspondenciasclase_id}'"
    end
    if asunto.to_s != ""
      s = asunto.upcase
      cadena << ' upper(asunto) like ' + "'%%#{s.to_s.strip}%%'"
    end
    if observacion.to_s != ""
      s = observacion.upcase
      cadena << ' upper(observacion) like ' + "'%%#{s.to_s.strip}%%'"
    end
    if empresa.to_s != ""
      s = empresa.upcase
      cadena << ' correspondenciasremitente_id in (select id from correspondenciasremitentes where entidad like ' + "'%%#{s.to_s.strip}%%'" + ')'
    end
    if empresar.to_s != ""
      s = empresar.upcase
      cadena << ' correspondenciasremitente_id in (select id from correspondenciasremitentes where nombre like ' + "'%%#{s.to_s.strip}%%'" + ')'
    end
    if recibidoemail.to_s != ""
      cadena << ' recibidoemail = ' + "'#{recibidoemail}'"
    end
    if clase.to_s != ""
      cadena << ' clase = ' + "'#{clase.strip}'"
    end
    if cadena.size > 0
      sqlDatos = ""
      sqlDatos << " #{cadena.join(" and ")}"
      paginate :per_page => 10, :page => page, :conditions => [sqlDatos], :order => 'to_number(nro_radicado), created_at desc'
    else
      paginate :per_page => 10, :page => page, :conditions => ["id = '-1'"]
    end
  end
=end
end
