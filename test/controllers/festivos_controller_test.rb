require 'test_helper'

class FestivosControllerTest < ActionDispatch::IntegrationTest
  setup do
    @festivo = festivos(:one)
  end

  test "should get index" do
    get festivos_url
    assert_response :success
  end

  test "should get new" do
    get new_festivo_url
    assert_response :success
  end

  test "should create festivo" do
    assert_difference('Festivo.count') do
      post festivos_url, params: { festivo: { fecha: @festivo.fecha } }
    end

    assert_redirected_to festivo_url(Festivo.last)
  end

  test "should show festivo" do
    get festivo_url(@festivo)
    assert_response :success
  end

  test "should get edit" do
    get edit_festivo_url(@festivo)
    assert_response :success
  end

  test "should update festivo" do
    patch festivo_url(@festivo), params: { festivo: { fecha: @festivo.fecha } }
    assert_redirected_to festivo_url(@festivo)
  end

  test "should destroy festivo" do
    assert_difference('Festivo.count', -1) do
      delete festivo_url(@festivo)
    end

    assert_redirected_to festivos_url
  end
end
