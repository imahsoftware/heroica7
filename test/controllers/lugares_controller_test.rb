require 'test_helper'

class LugaresControllerTest < ActionDispatch::IntegrationTest
  setup do
    @lugar = lugares(:one)
  end

  test "should get index" do
    get lugares_url
    assert_response :success
  end

  test "should get new" do
    get new_lugar_url
    assert_response :success
  end

  test "should create lugar" do
    assert_difference('Lugar.count') do
      post lugares_url, params: { lugar: { descripcion: @lugar.descripcion, descripcion_ampliada: @lugar.descripcion_ampliada } }
    end

    assert_redirected_to lugar_url(Lugar.last)
  end

  test "should show lugar" do
    get lugar_url(@lugar)
    assert_response :success
  end

  test "should get edit" do
    get edit_lugar_url(@lugar)
    assert_response :success
  end

  test "should update lugar" do
    patch lugar_url(@lugar), params: { lugar: { descripcion: @lugar.descripcion, descripcion_ampliada: @lugar.descripcion_ampliada } }
    assert_redirected_to lugar_url(@lugar)
  end

  test "should destroy lugar" do
    assert_difference('Lugar.count', -1) do
      delete lugar_url(@lugar)
    end

    assert_redirected_to lugares_url
  end
end
