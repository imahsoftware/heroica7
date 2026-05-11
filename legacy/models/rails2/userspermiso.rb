class Userspermiso < ActiveRecord::Base
  belongs_to :user
  belongs_to :objeto

  validates_presence_of :objeto_id
  validates_uniqueness_of :objeto_id, :scope => :user_id

end
