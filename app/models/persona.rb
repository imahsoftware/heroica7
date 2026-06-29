# frozen_string_literal: true

class Persona < ApplicationRecord
  has_many :personastramites
  has_many :personasclases
  has_many :facturas
  has_many :abonos
  has_many :teoricos
  has_many :teoricosresultados
  has_many :programacioneshorarios

  has_attached_file :personasimagen
  validates_attachment_content_type :personasimagen, content_type: /\Aimage\/.*\z/

  validates :identificacion, presence: true, uniqueness: true, numericality: true
  validates :primer_nombre,  presence: true
  validates :primer_apellido, presence: true
  validates :telefono,        numericality: true, allow_nil: true, allow_blank: true
  validates :telefono_oficina, numericality: true, allow_nil: true, allow_blank: true
  validates :celular,         numericality: true, allow_nil: true, allow_blank: true

  before_save :build_autobuscar

  # ── Métodos de instancia ──────────────────────────────────────────────────

  def nombres
    [primer_nombre, segundo_nombre, primer_apellido, segundo_apellido]
      .compact.reject(&:blank?).join(' ')
  end

  def tipodocumento
    case documento.to_s
    when 'CC'  then 'Cedula de Ciudadania'
    when 'TI'  then 'Tarjeta de Identidad'
    when 'PAS' then 'Pasaporte'
    when 'CE'  then 'Cedula de Extanjeria'
    end
  end

  def generos
    case genero.to_s
    when 'true'  then 'MASCULINO'
    when 'false' then 'FEMENINO'
    end
  end

  def siet_nombres
    "#{primer_nombre} #{segundo_nombre}"
  end

  def siet_apellidos
    "#{primer_apellido} #{segundo_apellido}"
  end

  def siet_tipodocumento
    case documento.to_s
    when 'CC'  then '1) CEDULA DE CIUDADANÍA'
    when 'TI'  then '2) TARJETA DE IDENTIDAD'
    when 'PAS' then '5) PASAPORTE'
    when 'CE'  then '4) CEDULA DE EXTRANJERÍA'
    end
  end

  def siet_genero
    case genero.to_s
    when 'true'  then '1) MASCULINO'
    when 'false' then '2) FEMENINO'
    end
  end

  # ── Métodos de clase ──────────────────────────────────────────────────────

  def self.buscar(buscarident, buscarnombre)
    cadena = []
    conditions = []

    if buscarident.present?
      cadena << "identificacion = ?"
      conditions << buscarident.to_s
    end

    if buscarnombre.present?
      cadena << "autobuscar LIKE ?"
      conditions << "%#{buscarnombre.upcase}%"
    end

    if cadena.any?
      where([cadena.join(' AND ')] + conditions)
        .order(:primer_nombre, :segundo_nombre, :primer_apellido, :segundo_apellido)
    else
      where('DATE(created_at) = CURDATE()')
        .order(:primer_nombre, :segundo_nombre, :primer_apellido, :segundo_apellido)
    end
  end

  private

  def build_autobuscar
    self.autobuscar = [identificacion, primer_nombre, segundo_nombre,
                       primer_apellido, segundo_apellido]
                        .compact.reject(&:blank?).join(' ')
  end
end
