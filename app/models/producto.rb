class Producto < ApplicationRecord
  belongs_to :user, optional: true
  has_many :comprasdetalles, class_name: 'Comprasdetalle', foreign_key: 'producto_id', dependent: :restrict_with_error

  validates :descripcion, presence: true

  def self.ransackable_attributes(auth_object = nil)
    %w[descripcion]
  end

  def self.ransackable_associations(auth_object = nil)
    []
  end
end
