class Comprasdetalle < ApplicationRecord
  belongs_to :user,     optional: true
  belongs_to :compra,   optional: true
  belongs_to :producto, optional: true

  validates :producto_id,    presence: true
  validates :cantidad,       presence: true, numericality: { greater_than: 0 }
  validates :valor_unitario, presence: true, numericality: { greater_than_or_equal_to: 0 }
  validates :valor_descuento, presence: true, numericality: { greater_than_or_equal_to: 0 }
end
