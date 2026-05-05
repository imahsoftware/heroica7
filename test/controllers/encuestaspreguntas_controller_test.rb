require 'test_helper'

class EncuestaspreguntasControllerTest < ActionDispatch::IntegrationTest
  setup do
    @encuestaspregunta = encuestaspreguntas(:one)
  end

  test "should get index" do
    get encuestaspreguntas_url
    assert_response :success
  end

  test "should get new" do
    get new_encuestaspregunta_url
    assert_response :success
  end

  test "should create encuestaspregunta" do
    assert_difference('Encuestaspregunta.count') do
      post encuestaspreguntas_url, params: { encuestaspregunta: { encuesta_id: @encuestaspregunta.encuesta_id, imagen: @encuestaspregunta.imagen, pregunta: @encuestaspregunta.pregunta } }
    end

    assert_redirected_to encuestaspregunta_url(Encuestaspregunta.last)
  end

  test "should show encuestaspregunta" do
    get encuestaspregunta_url(@encuestaspregunta)
    assert_response :success
  end

  test "should get edit" do
    get edit_encuestaspregunta_url(@encuestaspregunta)
    assert_response :success
  end

  test "should update encuestaspregunta" do
    patch encuestaspregunta_url(@encuestaspregunta), params: { encuestaspregunta: { encuesta_id: @encuestaspregunta.encuesta_id, imagen: @encuestaspregunta.imagen, pregunta: @encuestaspregunta.pregunta } }
    assert_redirected_to encuestaspregunta_url(@encuestaspregunta)
  end

  test "should destroy encuestaspregunta" do
    assert_difference('Encuestaspregunta.count', -1) do
      delete encuestaspregunta_url(@encuestaspregunta)
    end

    assert_redirected_to encuestaspreguntas_url
  end
end
