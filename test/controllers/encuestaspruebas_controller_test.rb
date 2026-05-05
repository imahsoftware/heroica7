require 'test_helper'

class EncuestaspruebasControllerTest < ActionDispatch::IntegrationTest
  setup do
    @encuestasprueba = encuestaspruebas(:one)
  end

  test "should get index" do
    get encuestaspruebas_url
    assert_response :success
  end

  test "should get new" do
    get new_encuestasprueba_url
    assert_response :success
  end

  test "should create encuestasprueba" do
    assert_difference('Encuestasprueba.count') do
      post encuestaspruebas_url, params: { encuestasprueba: { encuesta_id: @encuestasprueba.encuesta_id, estado: @encuestasprueba.estado, persona_id: @encuestasprueba.persona_id, personastramite_id: @encuestasprueba.personastramite_id } }
    end

    assert_redirected_to encuestasprueba_url(Encuestasprueba.last)
  end

  test "should show encuestasprueba" do
    get encuestasprueba_url(@encuestasprueba)
    assert_response :success
  end

  test "should get edit" do
    get edit_encuestasprueba_url(@encuestasprueba)
    assert_response :success
  end

  test "should update encuestasprueba" do
    patch encuestasprueba_url(@encuestasprueba), params: { encuestasprueba: { encuesta_id: @encuestasprueba.encuesta_id, estado: @encuestasprueba.estado, persona_id: @encuestasprueba.persona_id, personastramite_id: @encuestasprueba.personastramite_id } }
    assert_redirected_to encuestasprueba_url(@encuestasprueba)
  end

  test "should destroy encuestasprueba" do
    assert_difference('Encuestasprueba.count', -1) do
      delete encuestasprueba_url(@encuestasprueba)
    end

    assert_redirected_to encuestaspruebas_url
  end
end
