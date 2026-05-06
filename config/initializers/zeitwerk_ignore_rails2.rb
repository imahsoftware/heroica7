# Ignorar carpetas rails2 — son archivos de referencia para migración,
# no deben ser cargados por Zeitwerk ni por helper :all
Rails.autoloaders.main.ignore(
  Rails.root.join('app/controllers/rails2'),
  Rails.root.join('app/helpers/rails2'),
  Rails.root.join('app/models/rails2')
)
