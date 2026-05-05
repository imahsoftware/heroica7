require 'test_helper'

class ProgramacioneshorariosControllerTest < ActionDispatch::IntegrationTest
  setup do
    @programacioneshorario = programacioneshorarios(:one)
  end

  test "should get index" do
    get programacioneshorarios_url
    assert_response :success
  end

  test "should get new" do
    get new_programacioneshorario_url
    assert_response :success
  end

  test "should create programacioneshorario" do
    assert_difference('Programacioneshorario.count') do
      post programacioneshorarios_url, params: { programacioneshorario: { estado: @programacioneshorario.estado, instructor_id: @programacioneshorario.instructor_id, observacion: @programacioneshorario.observacion, persona_id: @programacioneshorario.persona_id, personastramite_id: @programacioneshorario.personastramite_id, placa_id: @programacioneshorario.placa_id, recoje: @programacioneshorario.recoje, tiposhorario_id: @programacioneshorario.tiposhorario_id, user_actualiza: @programacioneshorario.user_actualiza, user_programa: @programacioneshorario.user_programa } }
    end

    assert_redirected_to programacioneshorario_url(Programacioneshorario.last)
  end

  test "should show programacioneshorario" do
    get programacioneshorario_url(@programacioneshorario)
    assert_response :success
  end

  test "should get edit" do
    get edit_programacioneshorario_url(@programacioneshorario)
    assert_response :success
  end

  test "should update programacioneshorario" do
    patch programacioneshorario_url(@programacioneshorario), params: { programacioneshorario: { estado: @programacioneshorario.estado, instructor_id: @programacioneshorario.instructor_id, observacion: @programacioneshorario.observacion, persona_id: @programacioneshorario.persona_id, personastramite_id: @programacioneshorario.personastramite_id, placa_id: @programacioneshorario.placa_id, recoje: @programacioneshorario.recoje, tiposhorario_id: @programacioneshorario.tiposhorario_id, user_actualiza: @programacioneshorario.user_actualiza, user_programa: @programacioneshorario.user_programa } }
    assert_redirected_to programacioneshorario_url(@programacioneshorario)
  end

  test "should destroy programacioneshorario" do
    assert_difference('Programacioneshorario.count', -1) do
      delete programacioneshorario_url(@programacioneshorario)
    end

    assert_redirected_to programacioneshorarios_url
  end
end
