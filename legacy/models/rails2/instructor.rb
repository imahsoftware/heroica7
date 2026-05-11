class Instructor < ActiveRecord::Base
  has_many :personastramiteshoras
  has_many :placas
  has_many :personasclases
  has_many :programacioneshorarios
end
