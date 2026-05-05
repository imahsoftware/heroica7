require 'test_helper'

class TeoricosmateriasmodulosControllerTest < ActionDispatch::IntegrationTest
  setup do
    @teoricosmateriasmodulo = teoricosmateriasmodulos(:one)
  end

  test "should get index" do
    get teoricosmateriasmodulos_url
    assert_response :success
  end

  test "should get new" do
    get new_teoricosmateriasmodulo_url
    assert_response :success
  end

  test "should create teoricosmateriasmodulo" do
    assert_difference('Teoricosmateriasmodulo.count') do
      post teoricosmateriasmodulos_url, params: { teoricosmateriasmodulo: { teoricosmateria_id: @teoricosmateriasmodulo.teoricosmateria_id, teoricosmodulo_id: @teoricosmateriasmodulo.teoricosmodulo_id } }
    end

    assert_redirected_to teoricosmateriasmodulo_url(Teoricosmateriasmodulo.last)
  end

  test "should show teoricosmateriasmodulo" do
    get teoricosmateriasmodulo_url(@teoricosmateriasmodulo)
    assert_response :success
  end

  test "should get edit" do
    get edit_teoricosmateriasmodulo_url(@teoricosmateriasmodulo)
    assert_response :success
  end

  test "should update teoricosmateriasmodulo" do
    patch teoricosmateriasmodulo_url(@teoricosmateriasmodulo), params: { teoricosmateriasmodulo: { teoricosmateria_id: @teoricosmateriasmodulo.teoricosmateria_id, teoricosmodulo_id: @teoricosmateriasmodulo.teoricosmodulo_id } }
    assert_redirected_to teoricosmateriasmodulo_url(@teoricosmateriasmodulo)
  end

  test "should destroy teoricosmateriasmodulo" do
    assert_difference('Teoricosmateriasmodulo.count', -1) do
      delete teoricosmateriasmodulo_url(@teoricosmateriasmodulo)
    end

    assert_redirected_to teoricosmateriasmodulos_url
  end
end
