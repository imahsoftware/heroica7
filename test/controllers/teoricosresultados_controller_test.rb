require 'test_helper'

class TeoricosresultadosControllerTest < ActionDispatch::IntegrationTest
  setup do
    @teoricosresultado = teoricosresultados(:one)
  end

  test "should get index" do
    get teoricosresultados_url
    assert_response :success
  end

  test "should get new" do
    get new_teoricosresultado_url
    assert_response :success
  end

  test "should create teoricosresultado" do
    assert_difference('Teoricosresultado.count') do
      post teoricosresultados_url, params: { teoricosresultado: { estado: @teoricosresultado.estado, persona_id: @teoricosresultado.persona_id, pregunta_id: @teoricosresultado.pregunta_id, respuesta: @teoricosresultado.respuesta, teorico_id: @teoricosresultado.teorico_id } }
    end

    assert_redirected_to teoricosresultado_url(Teoricosresultado.last)
  end

  test "should show teoricosresultado" do
    get teoricosresultado_url(@teoricosresultado)
    assert_response :success
  end

  test "should get edit" do
    get edit_teoricosresultado_url(@teoricosresultado)
    assert_response :success
  end

  test "should update teoricosresultado" do
    patch teoricosresultado_url(@teoricosresultado), params: { teoricosresultado: { estado: @teoricosresultado.estado, persona_id: @teoricosresultado.persona_id, pregunta_id: @teoricosresultado.pregunta_id, respuesta: @teoricosresultado.respuesta, teorico_id: @teoricosresultado.teorico_id } }
    assert_redirected_to teoricosresultado_url(@teoricosresultado)
  end

  test "should destroy teoricosresultado" do
    assert_difference('Teoricosresultado.count', -1) do
      delete teoricosresultado_url(@teoricosresultado)
    end

    assert_redirected_to teoricosresultados_url
  end
end
