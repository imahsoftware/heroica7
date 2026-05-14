class Egresosimagen < ApplicationRecord
  belongs_to :egreso
  belongs_to :user, optional: true

  has_attached_file :egreso,
                    use_timestamp: false
  validates_attachment_content_type :egreso, content_type: /\A.*\/.*\Z/
  validates :egreso, attachment_presence: true, presence: true

  validates :descripcion, presence: { message: '* Obligatorio' }
end
