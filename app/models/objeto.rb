class Objeto < ApplicationRecord
  #audited
  
  validates_presence_of :descripcion, :descripcion_ampliada

  after_save :despuesdeguardar

  # Ransack 3.x — permitir atributos buscables explícitamente
  def self.ransackable_attributes(auth_object = nil)
    %w[descripcion descripcion_ampliada]
  end

  def self.ransackable_associations(auth_object = nil)
    []
  end

  def descripcionamp
  	 return self.descripcion_ampliada.to_s + ' ('+self.descripcion.to_s+')'
  end

  def despuesdeguardar
    @adminusers = User.where(geintac: 'S')
    @adminusers.each do |au|
      objetouser = Userspermiso.new(user_id: au.id, objeto_id: self.id, actualiza: 'S', crea: 'S', elimina: 'S')
      objetouser.save
    end
  end
end
