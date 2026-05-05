require 'test_helper'

class LiquidacionesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @liquidacion = liquidaciones(:one)
  end

  test "should get index" do
    get liquidaciones_url
    assert_response :success
  end

  test "should get new" do
    get new_liquidacion_url
    assert_response :success
  end

  test "should create liquidacion" do
    assert_difference('Liquidacion.count') do
      post liquidaciones_url, params: { liquidacion: { categoria_id: @liquidacion.categoria_id, empresa_id: @liquidacion.empresa_id, estado: @liquidacion.estado, factura_id: @liquidacion.factura_id, nro_liquidacion: @liquidacion.nro_liquidacion, persona_id: @liquidacion.persona_id, personastramite_id: @liquidacion.personastramite_id, tipostramite_id: @liquidacion.tipostramite_id, user_anula: @liquidacion.user_anula, user_id: @liquidacion.user_id, valor: @liquidacion.valor } }
    end

    assert_redirected_to liquidacion_url(Liquidacion.last)
  end

  test "should show liquidacion" do
    get liquidacion_url(@liquidacion)
    assert_response :success
  end

  test "should get edit" do
    get edit_liquidacion_url(@liquidacion)
    assert_response :success
  end

  test "should update liquidacion" do
    patch liquidacion_url(@liquidacion), params: { liquidacion: { categoria_id: @liquidacion.categoria_id, empresa_id: @liquidacion.empresa_id, estado: @liquidacion.estado, factura_id: @liquidacion.factura_id, nro_liquidacion: @liquidacion.nro_liquidacion, persona_id: @liquidacion.persona_id, personastramite_id: @liquidacion.personastramite_id, tipostramite_id: @liquidacion.tipostramite_id, user_anula: @liquidacion.user_anula, user_id: @liquidacion.user_id, valor: @liquidacion.valor } }
    assert_redirected_to liquidacion_url(@liquidacion)
  end

  test "should destroy liquidacion" do
    assert_difference('Liquidacion.count', -1) do
      delete liquidacion_url(@liquidacion)
    end

    assert_redirected_to liquidaciones_url
  end
end
