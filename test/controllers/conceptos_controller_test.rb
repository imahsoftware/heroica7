require 'test_helper'

class ConceptosControllerTest < ActionDispatch::IntegrationTest
  setup do
    @concepto = conceptos(:one)
  end

  test "should get index" do
    get conceptos_url
    assert_response :success
  end

  test "should get new" do
    get new_concepto_url
    assert_response :success
  end

  test "should create concepto" do
    assert_difference('Concepto.count') do
      post conceptos_url, params: { concepto: { codigo_contabilidad: @concepto.codigo_contabilidad, descripcion: @concepto.descripcion, propio: @concepto.propio, user_id: @concepto.user_id, valor: @concepto.valor } }
    end

    assert_redirected_to concepto_url(Concepto.last)
  end

  test "should show concepto" do
    get concepto_url(@concepto)
    assert_response :success
  end

  test "should get edit" do
    get edit_concepto_url(@concepto)
    assert_response :success
  end

  test "should update concepto" do
    patch concepto_url(@concepto), params: { concepto: { codigo_contabilidad: @concepto.codigo_contabilidad, descripcion: @concepto.descripcion, propio: @concepto.propio, user_id: @concepto.user_id, valor: @concepto.valor } }
    assert_redirected_to concepto_url(@concepto)
  end

  test "should destroy concepto" do
    assert_difference('Concepto.count', -1) do
      delete concepto_url(@concepto)
    end

    assert_redirected_to conceptos_url
  end
end
