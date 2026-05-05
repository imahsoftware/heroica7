require 'test_helper'

class DetallesfacturasControllerTest < ActionDispatch::IntegrationTest
  setup do
    @detallesfactura = detallesfacturas(:one)
  end

  test "should get index" do
    get detallesfacturas_url
    assert_response :success
  end

  test "should get new" do
    get new_detallesfactura_url
    assert_response :success
  end

  test "should create detallesfactura" do
    assert_difference('Detallesfactura.count') do
      post detallesfacturas_url, params: { detallesfactura: { cantidad: @detallesfactura.cantidad, categoria_id: @detallesfactura.categoria_id, concepto_id: @detallesfactura.concepto_id, descuento: @detallesfactura.descuento, factura_id: @detallesfactura.factura_id, liquidacion_id: @detallesfactura.liquidacion_id, nro_factura: @detallesfactura.nro_factura, observacion: @detallesfactura.observacion, tipostramite_id: @detallesfactura.tipostramite_id, user_actualiza: @detallesfactura.user_actualiza, user_id: @detallesfactura.user_id, valor: @detallesfactura.valor, valor_original: @detallesfactura.valor_original } }
    end

    assert_redirected_to detallesfactura_url(Detallesfactura.last)
  end

  test "should show detallesfactura" do
    get detallesfactura_url(@detallesfactura)
    assert_response :success
  end

  test "should get edit" do
    get edit_detallesfactura_url(@detallesfactura)
    assert_response :success
  end

  test "should update detallesfactura" do
    patch detallesfactura_url(@detallesfactura), params: { detallesfactura: { cantidad: @detallesfactura.cantidad, categoria_id: @detallesfactura.categoria_id, concepto_id: @detallesfactura.concepto_id, descuento: @detallesfactura.descuento, factura_id: @detallesfactura.factura_id, liquidacion_id: @detallesfactura.liquidacion_id, nro_factura: @detallesfactura.nro_factura, observacion: @detallesfactura.observacion, tipostramite_id: @detallesfactura.tipostramite_id, user_actualiza: @detallesfactura.user_actualiza, user_id: @detallesfactura.user_id, valor: @detallesfactura.valor, valor_original: @detallesfactura.valor_original } }
    assert_redirected_to detallesfactura_url(@detallesfactura)
  end

  test "should destroy detallesfactura" do
    assert_difference('Detallesfactura.count', -1) do
      delete detallesfactura_url(@detallesfactura)
    end

    assert_redirected_to detallesfacturas_url
  end
end
