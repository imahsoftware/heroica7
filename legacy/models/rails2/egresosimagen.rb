class Egresosimagen < ActiveRecord::Base
  belongs_to :egreso
  belongs_to :user

  has_attached_file :egreso
  validates_presence_of :descripcion
  validates_attachment_presence :egreso, :message => 'Debe seleccionar un archivo valido!!'

end
