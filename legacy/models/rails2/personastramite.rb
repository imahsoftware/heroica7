class Personastramite < ActiveRecord::Base
  belongs_to :persona
  belongs_to :categoria
  belongs_to :tipostramite
  belongs_to :placa
  belongs_to :user
  belongs_to :factura
  belongs_to :empresa
  has_many :personastramiteshoras

  validates_presence_of :categoria_id, :tipostramite_id
end
