class Cobrostramite < ActiveRecord::Base
  belongs_to :concepto
  belongs_to :categoria
  belongs_to :tipostramite
  belongs_to :user
end
