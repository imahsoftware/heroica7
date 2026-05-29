# Parche de compatibilidad Paperclip + Rails 7
# Rails 7 llama marked_for_destruction? durante callbacks de guardado,
# pero versiones antiguas de Paperclip no tienen ese metodo en Attachment.
module Paperclip
  class Attachment
    def marked_for_destruction?
      false
    end
  end
end
