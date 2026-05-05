require 'test_helper'

class TeoricosmateriasControllerTest < ActionDispatch::IntegrationTest
  setup do
    @teoricosmateria = teoricosmaterias(:one)
  end

  test "should get index" do
    get teoricosmaterias_url
    assert_response :success
  end

  test "should get new" do
    get new_teoricosmateria_url
    assert_response :success
  end

  test "should create teoricosmateria" do
    assert_difference('Teoricosmateria.count') do
      post teoricosmaterias_url, params: { teoricosmateria: { descripcion: @teoricosmateria.descripcion, estado: @teoricosmateria.estado, nro_horas: @teoricosmateria.nro_horas, temas: @teoricosmateria.temas } }
    end

    assert_redirected_to teoricosmateria_url(Teoricosmateria.last)
  end

  test "should show teoricosmateria" do
    get teoricosmateria_url(@teoricosmateria)
    assert_response :success
  end

  test "should get edit" do
    get edit_teoricosmateria_url(@teoricosmateria)
    assert_response :success
  end

  test "should update teoricosmateria" do
    patch teoricosmateria_url(@teoricosmateria), params: { teoricosmateria: { descripcion: @teoricosmateria.descripcion, estado: @teoricosmateria.estado, nro_horas: @teoricosmateria.nro_horas, temas: @teoricosmateria.temas } }
    assert_redirected_to teoricosmateria_url(@teoricosmateria)
  end

  test "should destroy teoricosmateria" do
    assert_difference('Teoricosmateria.count', -1) do
      delete teoricosmateria_url(@teoricosmateria)
    end

    assert_redirected_to teoricosmaterias_url
  end
end
