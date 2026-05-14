# frozen_string_literal: true

class Detallesfactura < ApplicationRecord
  belongs_to :concepto,    optional: true
  belongs_to :categoria,   optional: true
  belongs_to :tipostramite, optional: true
  belongs_to :factura,     optional: true
  belongs_to :user,        optional: true

  validates :concepto_id, presence: true
  validates :valor, presence: true, numericality: true

  after_save :recalcular_total_factura

  private

  def recalcular_total_factura
    ActiveRecord::Base.connection.execute(
      "UPDATE facturas SET valor = (SELECT SUM(valor) FROM detallesfacturas WHERE factura_id = #{factura_id}) WHERE id = #{factura_id}"
    )
  rescue StandardError
    nil
  end
end
