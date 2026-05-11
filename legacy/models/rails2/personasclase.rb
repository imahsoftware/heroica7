class Personasclase < ActiveRecord::Base
  belongs_to :persona
  belongs_to :tiposhorario
  belongs_to :placa
  belongs_to :instructor
  belongs_to :user

end
