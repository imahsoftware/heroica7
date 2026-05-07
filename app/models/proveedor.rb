class Proveedor < ApplicationRecord
  belongs_to :user, optional: true

  validates :identificacion, presence: true
  validates :documento,      presence: true

  DOCUMENTOS = [['C.C.', 'CC'], ['T.I.', 'TI'], ['NIT', 'NIT'], ['Pasaporte', 'PAS'], ['C.E.', 'CE']].freeze

  before_save :set_autobuscar

  def set_autobuscar
    if razon_social.present?
      self.autobuscar = razon_social.upcase
    else
      partes = [primer_nombre, segundo_nombre, primer_apellido, segundo_apellido].compact.map(&:upcase)
      self.autobuscar = partes.join(' ')
    end
  end

  def self.ransackable_attributes(auth_object = nil)
    %w[autobuscar identificacion razon_social contacto email ciudad]
  end

  def self.ransackable_associations(auth_object = nil)
    []
  end
end
