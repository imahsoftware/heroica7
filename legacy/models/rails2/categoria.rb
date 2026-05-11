class Categoria < ActiveRecord::Base
  has_many :personastramites
  has_many :cobrostramites
  has_many :detallesfacturas
  has_many :facturas
end
