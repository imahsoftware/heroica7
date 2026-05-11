class Persona < ActiveRecord::Base

  has_many :personastramites
  has_many :personasclases
  has_many :facturas
  has_many :abonos
  has_many :teoricos
  has_many :teoricosresultados
  
  validates_presence_of :identificacion, :primer_nombre, :primer_apellido
  validates_uniqueness_of :identificacion
  validates_numericality_of :identificacion
  validates_numericality_of :telefono, :allow_nil => true, :if => :telefono?
  validates_numericality_of :telefono_oficina, :allow_nil => true, :if => :telefono_oficina?
  validates_numericality_of :celular, :allow_nil => true, :if =>:celular?

  has_attached_file :personasimagen

  def before_save
    nom =  ""
    if self.identificacion.nil? == false
      nom = self.identificacion.to_s
    end
    if self.primer_nombre.nil? == false
      nom = nom + ' ' + self.primer_nombre.to_s
    end
    if self.segundo_nombre.nil? == false
      nom = nom + ' ' + self.segundo_nombre.to_s
    end
    if self.primer_apellido.nil? == false
      nom = nom + ' ' + self.primer_apellido.to_s
    end
    if self.segundo_apellido.nil? == false
      nom = nom + ' ' + self.segundo_apellido.to_s
    end
    self.autobuscar = nom
  end

  def nombres
    nom =  ""
    if self.primer_nombre.nil? == false
      nom = nom + ' ' + self.primer_nombre.to_s
    end
    if self.segundo_nombre.nil? == false
      nom = nom + ' ' + self.segundo_nombre.to_s
    end
    if self.primer_apellido.nil? == false
      nom = nom + ' ' + self.primer_apellido.to_s
    end
    if self.segundo_apellido.nil? == false
      nom = nom + ' ' + self.segundo_apellido.to_s
    end
    return nom
  end

  def self.buscar(buscarident, buscarnombre)
      cadena = ""
      if buscarident != ""
        if cadena != ""
          cadena = cadena + ' and identificacion  = ' + "'#{buscarident.to_s}'"
        else
          cadena = ' identificacion = ' + "'#{buscarident.to_s}'"
        end
      end
      if buscarnombre != ""
        s = buscarnombre.upcase
        if cadena != ""
          cadena = cadena + ' and autobuscar like '+ "'%%#{s.to_s}%%'"
        else
          cadena = ' autobuscar like '+ "'%%#{s.to_s}%%'"
        end
      end
      if cadena != ""
        find(:all, :conditions => [cadena], :order => 'primer_nombre, segundo_nombre,primer_apellido,segundo_apellido')
      else
        find(:all, :conditions => ['trunc(created_at) = trunc(sysdate)'], :order => 'primer_nombre, segundo_nombre,primer_apellido,segundo_apellido')
      end
  end

  def tipodocumento
    if self.documento.to_s == 'CC'
      return 'Cedula de Ciudadania'
    elsif self.documento.to_s == 'TI'
      return 'Tarjeta de Identidad'
    elsif self.documento.to_s == 'PAS'
      return 'Pasaporte'
    elsif self.documento.to_s == 'CE'
      return 'Cedula de Extanjeria'
    end
  end

  def generos
    if self.genero.to_s == 'true'
      return 'MASCULINO'
    elsif self.genero.to_s == 'false'
      return 'FEMENINO'
    end
  end
  
  def siet_nombres
    return self.primer_nombre.to_s + ' ' + self.segundo_nombre.to_s
  end

  def siet_apellidos
    return self.primer_apellido.to_s + ' ' + self.segundo_apellido.to_s
  end

  def siet_tipodocumento
    if self.documento.to_s == 'CC'
      return '1) CEDULA DE CIUDADANÍA'
    elsif self.documento.to_s == 'TI'
      return '2) TARJETA DE IDENTIDAD'
    elsif self.documento.to_s == 'PAS'
      return '5) PASAPORTE'
    elsif self.documento.to_s == 'CE'
      return '4) CEDULA DE EXTRANJERÍA'
    end
  end

  def siet_genero
    if self.genero.to_s == 'true'
      return '1) MASCULINO'
    elsif self.genero.to_s == 'false'
      return '2) FEMENINO'
    end
  end

end
