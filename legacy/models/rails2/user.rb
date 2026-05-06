class User < ActiveRecord::Base
  has_many :valoracionesdanos
  has_many :testigos
  has_many :gestiones
  has_many :obligaciones
  has_many :pendientes
  has_many :clientesoperadores
  has_many :monitoreos
  has_many :usersmodulos, :dependent =>:destroy
  has_many :userspermisos, :dependent =>:destroy
  has_many :falabellastipologiasusers, :dependent =>:destroy
  has_many :usersingresos
  has_many :personastramites
  has_many :conceptos
  has_many :cobrostramites
  has_many :factura
  has_many :detallesfacturas
  has_many :personasclases
  has_many :comprasdetalles
  has_many :compras
  has_many :proveedores
  
  acts_as_authentic

#  named_scope :with_role, lambda { |role| {:conditions => "roles_mask & #{2**ROLES.index(role.to_s)} > 0"} }
#
#  ROLES = %w[admin envios recibidos consultaenvios consultarecibidos consultatodo consultadashboard gerencia]
#
#  def roles=(roles)
#    self.roles_mask = (roles & ROLES).map { |r| 2**ROLES.index(r) }.sum
#  end
#
#  def roles
#    ROLES.reject { |r| ((roles_mask || 0) & 2**ROLES.index(r)).zero? }
#  end
#
#  def role?(role)
#    roles.include? role.to_s
#  end

  def self.search(search, page)
        paginate :per_page => 10,
                 :page => page,
                 :conditions => ['nombre like ?', "%#{search}%"],
                 :order => 'nombre'
  end
end
