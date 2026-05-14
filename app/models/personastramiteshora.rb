# frozen_string_literal: true

class Personastramiteshora < ApplicationRecord
  belongs_to :personastramite
  belongs_to :instructor, optional: true

  validates :fecha,       presence: true
  validates :practicas,   presence: true
  validates :teoricas,    presence: true
  validates :taller,      presence: true
  validates :instructor_id, presence: true

  def dtotal
    practicas.to_i + teoricas.to_i + taller.to_i
  end
end
