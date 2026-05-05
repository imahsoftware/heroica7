require 'test_helper'

class PlacasdocsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @placasdoc = placasdocs(:one)
  end

  test "should get index" do
    get placasdocs_url
    assert_response :success
  end

  test "should get new" do
    get new_placasdoc_url
    assert_response :success
  end

  test "should create placasdoc" do
    assert_difference('Placasdoc.count') do
      post placasdocs_url, params: { placasdoc: { placa_id: @placasdoc.placa_id, placadoc: @placasdoc.placadoc, user_id: @placasdoc.user_id } }
    end

    assert_redirected_to placasdoc_url(Placasdoc.last)
  end

  test "should show placasdoc" do
    get placasdoc_url(@placasdoc)
    assert_response :success
  end

  test "should get edit" do
    get edit_placasdoc_url(@placasdoc)
    assert_response :success
  end

  test "should update placasdoc" do
    patch placasdoc_url(@placasdoc), params: { placasdoc: { placa_id: @placasdoc.placa_id, placadoc: @placasdoc.placadoc, user_id: @placasdoc.user_id } }
    assert_redirected_to placasdoc_url(@placasdoc)
  end

  test "should destroy placasdoc" do
    assert_difference('Placasdoc.count', -1) do
      delete placasdoc_url(@placasdoc)
    end

    assert_redirected_to placasdocs_url
  end
end
