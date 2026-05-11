class Categoriasalerta < ActiveRecord::Base
  belongs_to :persona
  belongs_to :categoria
end
