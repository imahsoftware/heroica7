require 'test_helper'

class PersonastramitesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @personastramite = personastramites(:one)
  end

  test "should get index" do
    get personastramites_url
    assert_response :success
  end

  test "should get new" do
    get new_personastramite_url
    assert_response :success
  end

  test "should create personastramite" do
    assert_difference('Personastramite.count') do
      post personastramites_url, params: { personastramite: { autorizado: @personastramite.autorizado, autorizado_usado: @personastramite.autorizado_usado, autorizado_user: @personastramite.autorizado_user, categoria_id: @personastramite.categoria_id, documento_anterior: @personastramite.documento_anterior, empresa_id: @personastramite.empresa_id, factura_id: @personastramite.factura_id, identificacion_anterior: @personastramite.identificacion_anterior, liquidacion_id: @personastramite.liquidacion_id, nro_pin: @personastramite.nro_pin, persona_id: @personastramite.persona_id, placa_id: @personastramite.placa_id, restriccion_01: @personastramite.restriccion_01, restriccion_02: @personastramite.restriccion_02, restriccion_03: @personastramite.restriccion_03, restriccion_04: @personastramite.restriccion_04, restriccion_05: @personastramite.restriccion_05, restriccion_06: @personastramite.restriccion_06, restriccion_07: @personastramite.restriccion_07, restriccion_99: @personastramite.restriccion_99, tipostramite_id: @personastramite.tipostramite_id, usado: @personastramite.usado, user_actualiza: @personastramite.user_actualiza, user_id: @personastramite.user_id } }
    end

    assert_redirected_to personastramite_url(Personastramite.last)
  end

  test "should show personastramite" do
    get personastramite_url(@personastramite)
    assert_response :success
  end

  test "should get edit" do
    get edit_personastramite_url(@personastramite)
    assert_response :success
  end

  test "should update personastramite" do
    patch personastramite_url(@personastramite), params: { personastramite: { autorizado: @personastramite.autorizado, autorizado_usado: @personastramite.autorizado_usado, autorizado_user: @personastramite.autorizado_user, categoria_id: @personastramite.categoria_id, documento_anterior: @personastramite.documento_anterior, empresa_id: @personastramite.empresa_id, factura_id: @personastramite.factura_id, identificacion_anterior: @personastramite.identificacion_anterior, liquidacion_id: @personastramite.liquidacion_id, nro_pin: @personastramite.nro_pin, persona_id: @personastramite.persona_id, placa_id: @personastramite.placa_id, restriccion_01: @personastramite.restriccion_01, restriccion_02: @personastramite.restriccion_02, restriccion_03: @personastramite.restriccion_03, restriccion_04: @personastramite.restriccion_04, restriccion_05: @personastramite.restriccion_05, restriccion_06: @personastramite.restriccion_06, restriccion_07: @personastramite.restriccion_07, restriccion_99: @personastramite.restriccion_99, tipostramite_id: @personastramite.tipostramite_id, usado: @personastramite.usado, user_actualiza: @personastramite.user_actualiza, user_id: @personastramite.user_id } }
    assert_redirected_to personastramite_url(@personastramite)
  end

  test "should destroy personastramite" do
    assert_difference('Personastramite.count', -1) do
      delete personastramite_url(@personastramite)
    end

    assert_redirected_to personastramites_url
  end
end
