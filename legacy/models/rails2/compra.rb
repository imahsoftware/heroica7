class Compra < ActiveRecord::Base
  belongs_to :user
  has_many :comprasdetalles
end
