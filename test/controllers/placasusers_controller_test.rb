require 'test_helper'

class PlacasusersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @placasuser = placasusers(:one)
  end

  test "should get index" do
    get placasusers_url
    assert_response :success
  end

  test "should get new" do
    get new_placasuser_url
    assert_response :success
  end

  test "should create placasuser" do
    assert_difference('Placasuser.count') do
      post placasusers_url, params: { placasuser: { fecha_fin: @placasuser.fecha_fin, fecha_inicio: @placasuser.fecha_inicio, placa_id: @placasuser.placa_id, user_id: @placasuser.user_id } }
    end

    assert_redirected_to placasuser_url(Placasuser.last)
  end

  test "should show placasuser" do
    get placasuser_url(@placasuser)
    assert_response :success
  end

  test "should get edit" do
    get edit_placasuser_url(@placasuser)
    assert_response :success
  end

  test "should update placasuser" do
    patch placasuser_url(@placasuser), params: { placasuser: { fecha_fin: @placasuser.fecha_fin, fecha_inicio: @placasuser.fecha_inicio, placa_id: @placasuser.placa_id, user_id: @placasuser.user_id } }
    assert_redirected_to placasuser_url(@placasuser)
  end

  test "should destroy placasuser" do
    assert_difference('Placasuser.count', -1) do
      delete placasuser_url(@placasuser)
    end

    assert_redirected_to placasusers_url
  end
end
