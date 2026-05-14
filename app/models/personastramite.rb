# frozen_string_literal: true

class Personastramite < ApplicationRecord
  belongs_to :persona
  belongs_to :categoria,    optional: true
  belongs_to :tipostramite, optional: true
  belongs_to :placa,        optional: true
  belongs_to :user,         optional: true
  belongs_to :factura,      optional: true
  belongs_to :empresa,      optional: true
  has_many   :personastramiteshoras

  validates :categoria_id,    presence: true
  validates :tipostramite_id, presence: true

  def respaldo(user_id)
    # Preserva la lógica de respaldo del legacy antes de destroy
    update_columns(user_actualiza: user_id) rescue nil
  end
end
