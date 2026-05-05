require 'test_helper'

class PreguntasControllerTest < ActionDispatch::IntegrationTest
  setup do
    @pregunta = preguntas(:one)
  end

  test "should get index" do
    get preguntas_url
    assert_response :success
  end

  test "should get new" do
    get new_pregunta_url
    assert_response :success
  end

  test "should create pregunta" do
    assert_difference('Pregunta.count') do
      post preguntas_url, params: { pregunta: { codigo: @pregunta.codigo, descripcion: @pregunta.descripcion, grafica: @pregunta.grafica, grupo: @pregunta.grupo, multiple: @pregunta.multiple, opcion1: @pregunta.opcion1, opcion2: @pregunta.opcion2, opcion3: @pregunta.opcion3, opcion4: @pregunta.opcion4, opcion5: @pregunta.opcion5 } }
    end

    assert_redirected_to pregunta_url(Pregunta.last)
  end

  test "should show pregunta" do
    get pregunta_url(@pregunta)
    assert_response :success
  end

  test "should get edit" do
    get edit_pregunta_url(@pregunta)
    assert_response :success
  end

  test "should update pregunta" do
    patch pregunta_url(@pregunta), params: { pregunta: { codigo: @pregunta.codigo, descripcion: @pregunta.descripcion, grafica: @pregunta.grafica, grupo: @pregunta.grupo, multiple: @pregunta.multiple, opcion1: @pregunta.opcion1, opcion2: @pregunta.opcion2, opcion3: @pregunta.opcion3, opcion4: @pregunta.opcion4, opcion5: @pregunta.opcion5 } }
    assert_redirected_to pregunta_url(@pregunta)
  end

  test "should destroy pregunta" do
    assert_difference('Pregunta.count', -1) do
      delete pregunta_url(@pregunta)
    end

    assert_redirected_to preguntas_url
  end
end
