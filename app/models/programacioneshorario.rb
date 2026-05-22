# frozen_string_literal: true

class Programacioneshorario < ApplicationRecord
  belongs_to :persona
  belongs_to :tiposhorario, optional: true
  belongs_to :placa,        optional: true
  belongs_to :instructor,   optional: true

  def destado
    case estado
    when 'A' then 'ACTIVA'
    when 'I' then 'FINALIZADA'
    end
  end
end
