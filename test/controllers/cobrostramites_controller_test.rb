require 'test_helper'

class CobrostramitesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @cobrostramite = cobrostramites(:one)
  end

  test "should get index" do
    get cobrostramites_url
    assert_response :success
  end

  test "should get new" do
    get new_cobrostramite_url
    assert_response :success
  end

  test "should create cobrostramite" do
    assert_difference('Cobrostramite.count') do
      post cobrostramites_url, params: { cobrostramite: { categoria_id: @cobrostramite.categoria_id, concepto_id: @cobrostramite.concepto_id, tipostramite_id: @cobrostramite.tipostramite_id, user_id: @cobrostramite.user_id } }
    end

    assert_redirected_to cobrostramite_url(Cobrostramite.last)
  end

  test "should show cobrostramite" do
    get cobrostramite_url(@cobrostramite)
    assert_response :success
  end

  test "should get edit" do
    get edit_cobrostramite_url(@cobrostramite)
    assert_response :success
  end

  test "should update cobrostramite" do
    patch cobrostramite_url(@cobrostramite), params: { cobrostramite: { categoria_id: @cobrostramite.categoria_id, concepto_id: @cobrostramite.concepto_id, tipostramite_id: @cobrostramite.tipostramite_id, user_id: @cobrostramite.user_id } }
    assert_redirected_to cobrostramite_url(@cobrostramite)
  end

  test "should destroy cobrostramite" do
    assert_difference('Cobrostramite.count', -1) do
      delete cobrostramite_url(@cobrostramite)
    end

    assert_redirected_to cobrostramites_url
  end
end
