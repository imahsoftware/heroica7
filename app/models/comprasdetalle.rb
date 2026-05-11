class Comprasdetalle < ApplicationRecord
  belongs_to :user,     optional: true
  belongs_to :producto, optional: true
  belongs_to :compra
end
