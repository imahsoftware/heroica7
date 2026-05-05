require 'test_helper'

class TiposhorariosControllerTest < ActionDispatch::IntegrationTest
  setup do
    @tiposhorario = tiposhorarios(:one)
  end

  test "should get index" do
    get tiposhorarios_url
    assert_response :success
  end

  test "should get new" do
    get new_tiposhorario_url
    assert_response :success
  end

  test "should create tiposhorario" do
    assert_difference('Tiposhorario.count') do
      post tiposhorarios_url, params: { tiposhorario: { descripcion: @tiposhorario.descripcion } }
    end

    assert_redirected_to tiposhorario_url(Tiposhorario.last)
  end

  test "should show tiposhorario" do
    get tiposhorario_url(@tiposhorario)
    assert_response :success
  end

  test "should get edit" do
    get edit_tiposhorario_url(@tiposhorario)
    assert_response :success
  end

  test "should update tiposhorario" do
    patch tiposhorario_url(@tiposhorario), params: { tiposhorario: { descripcion: @tiposhorario.descripcion } }
    assert_redirected_to tiposhorario_url(@tiposhorario)
  end

  test "should destroy tiposhorario" do
    assert_difference('Tiposhorario.count', -1) do
      delete tiposhorario_url(@tiposhorario)
    end

    assert_redirected_to tiposhorarios_url
  end
end
