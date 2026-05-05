require 'test_helper'

class TeoricosmodulosControllerTest < ActionDispatch::IntegrationTest
  setup do
    @teoricosmodulo = teoricosmodulos(:one)
  end

  test "should get index" do
    get teoricosmodulos_url
    assert_response :success
  end

  test "should get new" do
    get new_teoricosmodulo_url
    assert_response :success
  end

  test "should create teoricosmodulo" do
    assert_difference('Teoricosmodulo.count') do
      post teoricosmodulos_url, params: { teoricosmodulo: { descripcion: @teoricosmodulo.descripcion, objetivo: @teoricosmodulo.objetivo } }
    end

    assert_redirected_to teoricosmodulo_url(Teoricosmodulo.last)
  end

  test "should show teoricosmodulo" do
    get teoricosmodulo_url(@teoricosmodulo)
    assert_response :success
  end

  test "should get edit" do
    get edit_teoricosmodulo_url(@teoricosmodulo)
    assert_response :success
  end

  test "should update teoricosmodulo" do
    patch teoricosmodulo_url(@teoricosmodulo), params: { teoricosmodulo: { descripcion: @teoricosmodulo.descripcion, objetivo: @teoricosmodulo.objetivo } }
    assert_redirected_to teoricosmodulo_url(@teoricosmodulo)
  end

  test "should destroy teoricosmodulo" do
    assert_difference('Teoricosmodulo.count', -1) do
      delete teoricosmodulo_url(@teoricosmodulo)
    end

    assert_redirected_to teoricosmodulos_url
  end
end
