# frozen_string_literal: true

class Personasclase < ApplicationRecord
  belongs_to :persona
  belongs_to :tiposhorario, optional: true
  belongs_to :placa,        optional: true
  belongs_to :instructor,   optional: true
  belongs_to :user,         optional: true
end
