class Placa < ActiveRecord::Base
  has_many :combustibles
  has_many :mantenimientos
  has_many :parqueaderos
  has_many :personastramites
  belongs_to :instructor
  has_many :programacioneshorarios
  has_many :personasclases
end
