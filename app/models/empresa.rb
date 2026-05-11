class Empresa < ApplicationRecord
  has_many :personastramites, dependent: :restrict_with_error

  DOCUMENTOS = [['C.C.', 'CC'], ['T.I.', 'TI'], ['NIT', 'NIT'],
                ['Pasaporte', 'PAS'], ['C.E.', 'CE']].freeze

  def self.ransackable_attributes(auth_object = nil)
    %w[documento identificacion nombre direccion telefono]
  end

  def self.ransackable_associations(auth_object = nil)
    []
  end
end
