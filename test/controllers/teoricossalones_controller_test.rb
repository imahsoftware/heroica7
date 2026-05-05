require 'test_helper'

class TeoricossalonesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @teoricossalon = teoricossalones(:one)
  end

  test "should get index" do
    get teoricossalones_url
    assert_response :success
  end

  test "should get new" do
    get new_teoricossalon_url
    assert_response :success
  end

  test "should create teoricossalon" do
    assert_difference('Teoricossalon.count') do
      post teoricossalones_url, params: { teoricossalon: { descripcion: @teoricossalon.descripcion, estado: @teoricossalon.estado } }
    end

    assert_redirected_to teoricossalon_url(Teoricossalon.last)
  end

  test "should show teoricossalon" do
    get teoricossalon_url(@teoricossalon)
    assert_response :success
  end

  test "should get edit" do
    get edit_teoricossalon_url(@teoricossalon)
    assert_response :success
  end

  test "should update teoricossalon" do
    patch teoricossalon_url(@teoricossalon), params: { teoricossalon: { descripcion: @teoricossalon.descripcion, estado: @teoricossalon.estado } }
    assert_redirected_to teoricossalon_url(@teoricossalon)
  end

  test "should destroy teoricossalon" do
    assert_difference('Teoricossalon.count', -1) do
      delete teoricossalon_url(@teoricossalon)
    end

    assert_redirected_to teoricossalones_url
  end
end
