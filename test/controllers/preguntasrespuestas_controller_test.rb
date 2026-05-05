require 'test_helper'

class PreguntasrespuestasControllerTest < ActionDispatch::IntegrationTest
  setup do
    @preguntasrespuesta = preguntasrespuestas(:one)
  end

  test "should get index" do
    get preguntasrespuestas_url
    assert_response :success
  end

  test "should get new" do
    get new_preguntasrespuesta_url
    assert_response :success
  end

  test "should create preguntasrespuesta" do
    assert_difference('Preguntasrespuesta.count') do
      post preguntasrespuestas_url, params: { preguntasrespuesta: { pregunta_id: @preguntasrespuesta.pregunta_id, respuesta: @preguntasrespuesta.respuesta } }
    end

    assert_redirected_to preguntasrespuesta_url(Preguntasrespuesta.last)
  end

  test "should show preguntasrespuesta" do
    get preguntasrespuesta_url(@preguntasrespuesta)
    assert_response :success
  end

  test "should get edit" do
    get edit_preguntasrespuesta_url(@preguntasrespuesta)
    assert_response :success
  end

  test "should update preguntasrespuesta" do
    patch preguntasrespuesta_url(@preguntasrespuesta), params: { preguntasrespuesta: { pregunta_id: @preguntasrespuesta.pregunta_id, respuesta: @preguntasrespuesta.respuesta } }
    assert_redirected_to preguntasrespuesta_url(@preguntasrespuesta)
  end

  test "should destroy preguntasrespuesta" do
    assert_difference('Preguntasrespuesta.count', -1) do
      delete preguntasrespuesta_url(@preguntasrespuesta)
    end

    assert_redirected_to preguntasrespuestas_url
  end
end
