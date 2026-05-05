require 'test_helper'

class NotascreditosControllerTest < ActionDispatch::IntegrationTest
  setup do
    @notascredito = notascreditos(:one)
  end

  test "should get index" do
    get notascreditos_url
    assert_response :success
  end

  test "should get new" do
    get new_notascredito_url
    assert_response :success
  end

  test "should create notascredito" do
    assert_difference('Notascredito.count') do
      post notascreditos_url, params: { notascredito: { estado: @notascredito.estado, factura_id: @notascredito.factura_id, observacion: @notascredito.observacion, saldo: @notascredito.saldo, user_anula: @notascredito.user_anula, user_id: @notascredito.user_id, valor: @notascredito.valor } }
    end

    assert_redirected_to notascredito_url(Notascredito.last)
  end

  test "should show notascredito" do
    get notascredito_url(@notascredito)
    assert_response :success
  end

  test "should get edit" do
    get edit_notascredito_url(@notascredito)
    assert_response :success
  end

  test "should update notascredito" do
    patch notascredito_url(@notascredito), params: { notascredito: { estado: @notascredito.estado, factura_id: @notascredito.factura_id, observacion: @notascredito.observacion, saldo: @notascredito.saldo, user_anula: @notascredito.user_anula, user_id: @notascredito.user_id, valor: @notascredito.valor } }
    assert_redirected_to notascredito_url(@notascredito)
  end

  test "should destroy notascredito" do
    assert_difference('Notascredito.count', -1) do
      delete notascredito_url(@notascredito)
    end

    assert_redirected_to notascreditos_url
  end
end
