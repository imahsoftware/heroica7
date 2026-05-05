require 'test_helper'

class AgendasbitacorasControllerTest < ActionDispatch::IntegrationTest
  setup do
    @agendasbitacora = agendasbitacoras(:one)
  end

  test "should get index" do
    get agendasbitacoras_url
    assert_response :success
  end

  test "should get new" do
    get new_agendasbitacora_url
    assert_response :success
  end

  test "should create agendasbitacora" do
    assert_difference('Agendasbitacora.count') do
      post agendasbitacoras_url, params: { agendasbitacora: { agenda_id: @agendasbitacora.agenda_id, estado: @agendasbitacora.estado, factura_id: @agendasbitacora.factura_id, persona_id: @agendasbitacora.persona_id, personastramite_id: @agendasbitacora.personastramite_id, user_id: @agendasbitacora.user_id } }
    end

    assert_redirected_to agendasbitacora_url(Agendasbitacora.last)
  end

  test "should show agendasbitacora" do
    get agendasbitacora_url(@agendasbitacora)
    assert_response :success
  end

  test "should get edit" do
    get edit_agendasbitacora_url(@agendasbitacora)
    assert_response :success
  end

  test "should update agendasbitacora" do
    patch agendasbitacora_url(@agendasbitacora), params: { agendasbitacora: { agenda_id: @agendasbitacora.agenda_id, estado: @agendasbitacora.estado, factura_id: @agendasbitacora.factura_id, persona_id: @agendasbitacora.persona_id, personastramite_id: @agendasbitacora.personastramite_id, user_id: @agendasbitacora.user_id } }
    assert_redirected_to agendasbitacora_url(@agendasbitacora)
  end

  test "should destroy agendasbitacora" do
    assert_difference('Agendasbitacora.count', -1) do
      delete agendasbitacora_url(@agendasbitacora)
    end

    assert_redirected_to agendasbitacoras_url
  end
end
