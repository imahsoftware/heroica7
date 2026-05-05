require 'test_helper'

class AbonosControllerTest < ActionDispatch::IntegrationTest
  setup do
    @abono = abonos(:one)
  end

  test "should get index" do
    get abonos_url
    assert_response :success
  end

  test "should get new" do
    get new_abono_url
    assert_response :success
  end

  test "should create abono" do
    assert_difference('Abono.count') do
      post abonos_url, params: { abono: { estado: @abono.estado, factura_id: @abono.factura_id, forma_pago: @abono.forma_pago, nro_abono: @abono.nro_abono, nro_factura: @abono.nro_factura, saldo: @abono.saldo, user_anula: @abono.user_anula, user_id: @abono.user_id, valor: @abono.valor } }
    end

    assert_redirected_to abono_url(Abono.last)
  end

  test "should show abono" do
    get abono_url(@abono)
    assert_response :success
  end

  test "should get edit" do
    get edit_abono_url(@abono)
    assert_response :success
  end

  test "should update abono" do
    patch abono_url(@abono), params: { abono: { estado: @abono.estado, factura_id: @abono.factura_id, forma_pago: @abono.forma_pago, nro_abono: @abono.nro_abono, nro_factura: @abono.nro_factura, saldo: @abono.saldo, user_anula: @abono.user_anula, user_id: @abono.user_id, valor: @abono.valor } }
    assert_redirected_to abono_url(@abono)
  end

  test "should destroy abono" do
    assert_difference('Abono.count', -1) do
      delete abono_url(@abono)
    end

    assert_redirected_to abonos_url
  end
end
