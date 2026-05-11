class Detallesfactura < ActiveRecord::Base
  belongs_to :concepto
  belongs_to :categoria
  belongs_to :tipostramite
  belongs_to :factura
  belongs_to :user

  validates_presence_of :concepto_id, :valor
  validates_numericality_of :valor

  def after_save
    ActiveRecord::Base.connection.execute("update facturas set valor = (select sum(valor) from detallesfacturas where factura_id = facturas.id) where id = #{self.factura_id}")
  end

end
