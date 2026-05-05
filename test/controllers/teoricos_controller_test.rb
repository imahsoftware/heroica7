require 'test_helper'

class TeoricosControllerTest < ActionDispatch::IntegrationTest
  setup do
    @teorico = teoricos(:one)
  end

  test "should get index" do
    get teoricos_url
    assert_response :success
  end

  test "should get new" do
    get new_teorico_url
    assert_response :success
  end

  test "should create teorico" do
    assert_difference('Teorico.count') do
      post teoricos_url, params: { teorico: { categoria_id: @teorico.categoria_id, correctas: @teorico.correctas, estado: @teorico.estado, incorrectas: @teorico.incorrectas, persona_id: @teorico.persona_id, portafolio_id: @teorico.portafolio_id, user_id: @teorico.user_id } }
    end

    assert_redirected_to teorico_url(Teorico.last)
  end

  test "should show teorico" do
    get teorico_url(@teorico)
    assert_response :success
  end

  test "should get edit" do
    get edit_teorico_url(@teorico)
    assert_response :success
  end

  test "should update teorico" do
    patch teorico_url(@teorico), params: { teorico: { categoria_id: @teorico.categoria_id, correctas: @teorico.correctas, estado: @teorico.estado, incorrectas: @teorico.incorrectas, persona_id: @teorico.persona_id, portafolio_id: @teorico.portafolio_id, user_id: @teorico.user_id } }
    assert_redirected_to teorico_url(@teorico)
  end

  test "should destroy teorico" do
    assert_difference('Teorico.count', -1) do
      delete teorico_url(@teorico)
    end

    assert_redirected_to teoricos_url
  end
end
