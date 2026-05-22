# frozen_string_literal: true

class Tiposhorario < ApplicationRecord
  has_many :programacioneshorarios
  has_many :personasclases
end
