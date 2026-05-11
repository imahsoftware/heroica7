class Abono < ActiveRecord::Base
  belongs_to :factura
  belongs_to :user
  belongs_to :persona

  validates_presence_of :forma_pago, :valor
  validates_numericality_of :valor
  
  def destado
    if  self.estado == 'A'
      return 'ANULADO'
    elsif self.estado == 'C'
      return 'CANCELADO'
    end
  end
  
end
