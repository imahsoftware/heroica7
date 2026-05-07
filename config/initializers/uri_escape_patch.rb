# URI.escape fue eliminado en Ruby 3.0.
# Este parche lo restaura temporalmente para compatibilidad con Paperclip
# mientras se completa la migración a CarrierWave.
module URI
  def self.escape(str, unsafe = nil)
    if unsafe
      URI::DEFAULT_PARSER.escape(str, unsafe)
    else
      URI::DEFAULT_PARSER.escape(str)
    end
  end

  def self.unescape(str)
    URI::DEFAULT_PARSER.unescape(str)
  end
end
