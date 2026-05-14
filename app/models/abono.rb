# frozen_string_literal: true

class Abono < ApplicationRecord
  belongs_to :factura, optional: true
  belongs_to :user,    optional: true
  belongs_to :persona, optional: true

  validates :forma_pago, presence: true
  validates :valor, presence: true, numericality: true

  def destado
    case estado.to_s
    when 'A' then 'ANULADO'
    when 'C' then 'CANCELADO'
    end
  end
end
