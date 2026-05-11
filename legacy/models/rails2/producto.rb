class Producto < ActiveRecord::Base
  belongs_to :user
  has_many :comprasdetalle
end
