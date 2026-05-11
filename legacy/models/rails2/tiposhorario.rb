class Tiposhorario < ActiveRecord::Base
  has_many :programacioneshorarios
  has_many :personasclases
end
