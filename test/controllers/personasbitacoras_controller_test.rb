require 'test_helper'

class PersonasbitacorasControllerTest < ActionDispatch::IntegrationTest
  setup do
    @personasbitacora = personasbitacoras(:one)
  end

  test "should get index" do
    get personasbitacoras_url
    assert_response :success
  end

  test "should get new" do
    get new_personasbitacora_url
    assert_response :success
  end

  test "should create personasbitacora" do
    assert_difference('Personasbitacora.count') do
      post personasbitacoras_url, params: { personasbitacora: { codigo: @personasbitacora.codigo, fecha: @personasbitacora.fecha, personastramite_id: @personasbitacora.personastramite_id, placa_id: @personasbitacora.placa_id, respuesta: @personasbitacora.respuesta, tiposhorario_id: @personasbitacora.tiposhorario_id, user_id: @personasbitacora.user_id } }
    end

    assert_redirected_to personasbitacora_url(Personasbitacora.last)
  end

  test "should show personasbitacora" do
    get personasbitacora_url(@personasbitacora)
    assert_response :success
  end

  test "should get edit" do
    get edit_personasbitacora_url(@personasbitacora)
    assert_response :success
  end

  test "should update personasbitacora" do
    patch personasbitacora_url(@personasbitacora), params: { personasbitacora: { codigo: @personasbitacora.codigo, fecha: @personasbitacora.fecha, personastramite_id: @personasbitacora.personastramite_id, placa_id: @personasbitacora.placa_id, respuesta: @personasbitacora.respuesta, tiposhorario_id: @personasbitacora.tiposhorario_id, user_id: @personasbitacora.user_id } }
    assert_redirected_to personasbitacora_url(@personasbitacora)
  end

  test "should destroy personasbitacora" do
    assert_difference('Personasbitacora.count', -1) do
      delete personasbitacora_url(@personasbitacora)
    end

    assert_redirected_to personasbitacoras_url
  end
end
