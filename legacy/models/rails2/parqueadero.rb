class Parqueadero < ActiveRecord::Base

  belongs_to :placa

  def self.buscar(placa)
      if placa.to_s != ""
        find(:all, :conditions => [' placa_id = ? ', "#{placa}"])
      end
  end
end
