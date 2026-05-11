class Usersmodulo < ActiveRecord::Base
  belongs_to :user
  belongs_to :modulo

  validates_presence_of :modulo_id
  validates_uniqueness_of :modulo_id, :scope => :user_id
end
