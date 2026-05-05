require 'test_helper'

class PlacasregistrosControllerTest < ActionDispatch::IntegrationTest
  setup do
    @placasregistro = placasregistros(:one)
  end

  test "should get index" do
    get placasregistros_url
    assert_response :success
  end

  test "should get new" do
    get new_placasregistro_url
    assert_response :success
  end

  test "should create placasregistro" do
    assert_difference('Placasregistro.count') do
      post placasregistros_url, params: { placasregistro: { fecha: @placasregistro.fecha, galones: @placasregistro.galones, kilometraje: @placasregistro.kilometraje, placa_id: @placasregistro.placa_id, valor: @placasregistro.valor } }
    end

    assert_redirected_to placasregistro_url(Placasregistro.last)
  end

  test "should show placasregistro" do
    get placasregistro_url(@placasregistro)
    assert_response :success
  end

  test "should get edit" do
    get edit_placasregistro_url(@placasregistro)
    assert_response :success
  end

  test "should update placasregistro" do
    patch placasregistro_url(@placasregistro), params: { placasregistro: { fecha: @placasregistro.fecha, galones: @placasregistro.galones, kilometraje: @placasregistro.kilometraje, placa_id: @placasregistro.placa_id, valor: @placasregistro.valor } }
    assert_redirected_to placasregistro_url(@placasregistro)
  end

  test "should destroy placasregistro" do
    assert_difference('Placasregistro.count', -1) do
      delete placasregistro_url(@placasregistro)
    end

    assert_redirected_to placasregistros_url
  end
end
