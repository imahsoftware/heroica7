class ImportFileJob < ApplicationJob

  queue_as :sidekiq

  def perform(path, is_portafolio, archivoId, *args)
    Archivo.import(path, is_portafolio, archivoId)
  end
end
