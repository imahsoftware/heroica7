class Cobrostramite < ApplicationRecord
  belongs_to :categoria
  belongs_to :tipostramite
  belongs_to :concepto
  belongs_to :user, optional: true

  validates :categoria_id,    presence: true
  validates :tipostramite_id, presence: true
  validates :concepto_id,     presence: true

  def self.ransackable_attributes(auth_object = nil)
    %w[categoria_id tipostramite_id concepto_id]
  end

  def self.ransackable_associations(auth_object = nil)
    %w[categoria tipostramite concepto]
  end
end
