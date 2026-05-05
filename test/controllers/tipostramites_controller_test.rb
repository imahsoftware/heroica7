require 'test_helper'

class TipostramitesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @tipostramite = tipostramites(:one)
  end

  test "should get index" do
    get tipostramites_url
    assert_response :success
  end

  test "should get new" do
    get new_tipostramite_url
    assert_response :success
  end

  test "should create tipostramite" do
    assert_difference('Tipostramite.count') do
      post tipostramites_url, params: { tipostramite: { descripcion: @tipostramite.descripcion, estado: @tipostramite.estado, ministerio: @tipostramite.ministerio, programa: @tipostramite.programa } }
    end

    assert_redirected_to tipostramite_url(Tipostramite.last)
  end

  test "should show tipostramite" do
    get tipostramite_url(@tipostramite)
    assert_response :success
  end

  test "should get edit" do
    get edit_tipostramite_url(@tipostramite)
    assert_response :success
  end

  test "should update tipostramite" do
    patch tipostramite_url(@tipostramite), params: { tipostramite: { descripcion: @tipostramite.descripcion, estado: @tipostramite.estado, ministerio: @tipostramite.ministerio, programa: @tipostramite.programa } }
    assert_redirected_to tipostramite_url(@tipostramite)
  end

  test "should destroy tipostramite" do
    assert_difference('Tipostramite.count', -1) do
      delete tipostramite_url(@tipostramite)
    end

    assert_redirected_to tipostramites_url
  end
end
