require 'test_helper'

class TeoricosmateriascategoriasControllerTest < ActionDispatch::IntegrationTest
  setup do
    @teoricosmateriascategoria = teoricosmateriascategorias(:one)
  end

  test "should get index" do
    get teoricosmateriascategorias_url
    assert_response :success
  end

  test "should get new" do
    get new_teoricosmateriascategoria_url
    assert_response :success
  end

  test "should create teoricosmateriascategoria" do
    assert_difference('Teoricosmateriascategoria.count') do
      post teoricosmateriascategorias_url, params: { teoricosmateriascategoria: { categoria_id: @teoricosmateriascategoria.categoria_id, teoricosmateria_id: @teoricosmateriascategoria.teoricosmateria_id, tipostramite_id: @teoricosmateriascategoria.tipostramite_id } }
    end

    assert_redirected_to teoricosmateriascategoria_url(Teoricosmateriascategoria.last)
  end

  test "should show teoricosmateriascategoria" do
    get teoricosmateriascategoria_url(@teoricosmateriascategoria)
    assert_response :success
  end

  test "should get edit" do
    get edit_teoricosmateriascategoria_url(@teoricosmateriascategoria)
    assert_response :success
  end

  test "should update teoricosmateriascategoria" do
    patch teoricosmateriascategoria_url(@teoricosmateriascategoria), params: { teoricosmateriascategoria: { categoria_id: @teoricosmateriascategoria.categoria_id, teoricosmateria_id: @teoricosmateriascategoria.teoricosmateria_id, tipostramite_id: @teoricosmateriascategoria.tipostramite_id } }
    assert_redirected_to teoricosmateriascategoria_url(@teoricosmateriascategoria)
  end

  test "should destroy teoricosmateriascategoria" do
    assert_difference('Teoricosmateriascategoria.count', -1) do
      delete teoricosmateriascategoria_url(@teoricosmateriascategoria)
    end

    assert_redirected_to teoricosmateriascategorias_url
  end
end
