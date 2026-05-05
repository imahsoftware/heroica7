require 'test_helper'

class LiquidacionesdetallesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @liquidacionesdetalle = liquidacionesdetalles(:one)
  end

  test "should get index" do
    get liquidacionesdetalles_url
    assert_response :success
  end

  test "should get new" do
    get new_liquidacionesdetalle_url
    assert_response :success
  end

  test "should create liquidacionesdetalle" do
    assert_difference('Liquidacionesdetalle.count') do
      post liquidacionesdetalles_url, params: { liquidacionesdetalle: { cantidad: @liquidacionesdetalle.cantidad, categoria_id: @liquidacionesdetalle.categoria_id, concepto_id: @liquidacionesdetalle.concepto_id, liquidacion_id: @liquidacionesdetalle.liquidacion_id, tipostramite_id: @liquidacionesdetalle.tipostramite_id, user_actualiza: @liquidacionesdetalle.user_actualiza, user_id: @liquidacionesdetalle.user_id, valor: @liquidacionesdetalle.valor } }
    end

    assert_redirected_to liquidacionesdetalle_url(Liquidacionesdetalle.last)
  end

  test "should show liquidacionesdetalle" do
    get liquidacionesdetalle_url(@liquidacionesdetalle)
    assert_response :success
  end

  test "should get edit" do
    get edit_liquidacionesdetalle_url(@liquidacionesdetalle)
    assert_response :success
  end

  test "should update liquidacionesdetalle" do
    patch liquidacionesdetalle_url(@liquidacionesdetalle), params: { liquidacionesdetalle: { cantidad: @liquidacionesdetalle.cantidad, categoria_id: @liquidacionesdetalle.categoria_id, concepto_id: @liquidacionesdetalle.concepto_id, liquidacion_id: @liquidacionesdetalle.liquidacion_id, tipostramite_id: @liquidacionesdetalle.tipostramite_id, user_actualiza: @liquidacionesdetalle.user_actualiza, user_id: @liquidacionesdetalle.user_id, valor: @liquidacionesdetalle.valor } }
    assert_redirected_to liquidacionesdetalle_url(@liquidacionesdetalle)
  end

  test "should destroy liquidacionesdetalle" do
    assert_difference('Liquidacionesdetalle.count', -1) do
      delete liquidacionesdetalle_url(@liquidacionesdetalle)
    end

    assert_redirected_to liquidacionesdetalles_url
  end
end
