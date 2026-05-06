class Portafolio < ApplicationRecord
	#audited


	has_many :users


	has_attached_file :logo, styles: { medium: "300x300>", thumb: "100x100>" }, default_url: "/assets/logo.png"
  validates_attachment_content_type :logo, content_type: /\Aimage\/.*\z/
  
	#validates :email, presence: true
	#validates :estado, presence: true
	#validates :negociacion_contado, presence: true
	#validates :nombrefile, presence: true

	def parametrizacionacuerdos
		if self.acuerdos_fechas == 'SI'
			return true
		else
			return false
		end
  end
end
