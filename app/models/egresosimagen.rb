class Egresosimagen < ApplicationRecord
  belongs_to :egreso
  belongs_to :user, optional: true

  has_attached_file :docfile,
                    use_timestamp: false
  validates_attachment_content_type :docfile, content_type: /\A.*\/.*\Z/
  validates :docfile, attachment_presence: true, presence: true

  validates :descripcion, presence: { message: '* Obligatorio' }
end
