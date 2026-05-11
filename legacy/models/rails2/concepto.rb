class Concepto < ActiveRecord::Base
  belongs_to :user
  has_many :cobrostramites
  has_many :detallesfacturas
end
