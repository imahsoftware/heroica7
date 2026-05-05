require 'test_helper'

class PreguntascategoriasControllerTest < ActionDispatch::IntegrationTest
  setup do
    @preguntascategoria = preguntascategorias(:one)
  end

  test "should get index" do
    get preguntascategorias_url
    assert_response :success
  end

  test "should get new" do
    get new_preguntascategoria_url
    assert_response :success
  end

  test "should create preguntascategoria" do
    assert_difference('Preguntascategoria.count') do
      post preguntascategorias_url, params: { preguntascategoria: { categoria_id: @preguntascategoria.categoria_id, pregunta_id: @preguntascategoria.pregunta_id } }
    end

    assert_redirected_to preguntascategoria_url(Preguntascategoria.last)
  end

  test "should show preguntascategoria" do
    get preguntascategoria_url(@preguntascategoria)
    assert_response :success
  end

  test "should get edit" do
    get edit_preguntascategoria_url(@preguntascategoria)
    assert_response :success
  end

  test "should update preguntascategoria" do
    patch preguntascategoria_url(@preguntascategoria), params: { preguntascategoria: { categoria_id: @preguntascategoria.categoria_id, pregunta_id: @preguntascategoria.pregunta_id } }
    assert_redirected_to preguntascategoria_url(@preguntascategoria)
  end

  test "should destroy preguntascategoria" do
    assert_difference('Preguntascategoria.count', -1) do
      delete preguntascategoria_url(@preguntascategoria)
    end

    assert_redirected_to preguntascategorias_url
  end
end
