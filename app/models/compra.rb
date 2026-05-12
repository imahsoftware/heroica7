class Compra < ApplicationRecord
  belongs_to :user
  has_many :comprasdetalles
end
