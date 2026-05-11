class Comprasdetalle < ActiveRecord::Base
  belongs_to :user
  belongs_to :compra
  belongs_to :producto
end
