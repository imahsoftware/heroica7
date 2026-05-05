class Usersimagen < ApplicationRecord
  belongs_to :user

  has_attached_file :docuser
  validates_attachment_content_type :docuser, content_type: /\A*\/.*\Z/
  validates :docuser, attachment_presence: true, presence: true

  validates_presence_of :descripcion, message: "* Obligatorio"

end
