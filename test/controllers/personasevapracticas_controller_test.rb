require 'test_helper'

class PersonasevapracticasControllerTest < ActionDispatch::IntegrationTest
  setup do
    @personasevapractica = personasevapracticas(:one)
  end

  test "should get index" do
    get personasevapracticas_url
    assert_response :success
  end

  test "should get new" do
    get new_personasevapractica_url
    assert_response :success
  end

  test "should create personasevapractica" do
    assert_difference('Personasevapractica.count') do
      post personasevapracticas_url, params: { personasevapractica: { comportamiento_dato10: @personasevapractica.comportamiento_dato10, comportamiento_dato1: @personasevapractica.comportamiento_dato1, comportamiento_dato2: @personasevapractica.comportamiento_dato2, comportamiento_dato3: @personasevapractica.comportamiento_dato3, comportamiento_dato4: @personasevapractica.comportamiento_dato4, comportamiento_dato5: @personasevapractica.comportamiento_dato5, comportamiento_dato6: @personasevapractica.comportamiento_dato6, comportamiento_dato7: @personasevapractica.comportamiento_dato7, comportamiento_dato8: @personasevapractica.comportamiento_dato8, comportamiento_dato9: @personasevapractica.comportamiento_dato9, conocimiento_dato10: @personasevapractica.conocimiento_dato10, conocimiento_dato1: @personasevapractica.conocimiento_dato1, conocimiento_dato2: @personasevapractica.conocimiento_dato2, conocimiento_dato3: @personasevapractica.conocimiento_dato3, conocimiento_dato4: @personasevapractica.conocimiento_dato4, conocimiento_dato5: @personasevapractica.conocimiento_dato5, conocimiento_dato6: @personasevapractica.conocimiento_dato6, conocimiento_dato7: @personasevapractica.conocimiento_dato7, conocimiento_dato8: @personasevapractica.conocimiento_dato8, conocimiento_dato9: @personasevapractica.conocimiento_dato9, destreza_dato10: @personasevapractica.destreza_dato10, destreza_dato11: @personasevapractica.destreza_dato11, destreza_dato12: @personasevapractica.destreza_dato12, destreza_dato13: @personasevapractica.destreza_dato13, destreza_dato14: @personasevapractica.destreza_dato14, destreza_dato15: @personasevapractica.destreza_dato15, destreza_dato1: @personasevapractica.destreza_dato1, destreza_dato2: @personasevapractica.destreza_dato2, destreza_dato3: @personasevapractica.destreza_dato3, destreza_dato4: @personasevapractica.destreza_dato4, destreza_dato5: @personasevapractica.destreza_dato5, destreza_dato6: @personasevapractica.destreza_dato6, destreza_dato7: @personasevapractica.destreza_dato7, destreza_dato8: @personasevapractica.destreza_dato8, destreza_dato9: @personasevapractica.destreza_dato9, evaluacion: @personasevapractica.evaluacion, observaciones: @personasevapractica.observaciones, persona_id: @personasevapractica.persona_id, personastramite_id: @personasevapractica.personastramite_id, puntaje_comportamiento: @personasevapractica.puntaje_comportamiento, puntaje_conocimiento: @personasevapractica.puntaje_conocimiento, puntaje_destreza: @personasevapractica.puntaje_destreza, total: @personasevapractica.total, total_comportamiento: @personasevapractica.total_comportamiento, total_conocimiento: @personasevapractica.total_conocimiento, total_destreza: @personasevapractica.total_destreza, user_id: @personasevapractica.user_id } }
    end

    assert_redirected_to personasevapractica_url(Personasevapractica.last)
  end

  test "should show personasevapractica" do
    get personasevapractica_url(@personasevapractica)
    assert_response :success
  end

  test "should get edit" do
    get edit_personasevapractica_url(@personasevapractica)
    assert_response :success
  end

  test "should update personasevapractica" do
    patch personasevapractica_url(@personasevapractica), params: { personasevapractica: { comportamiento_dato10: @personasevapractica.comportamiento_dato10, comportamiento_dato1: @personasevapractica.comportamiento_dato1, comportamiento_dato2: @personasevapractica.comportamiento_dato2, comportamiento_dato3: @personasevapractica.comportamiento_dato3, comportamiento_dato4: @personasevapractica.comportamiento_dato4, comportamiento_dato5: @personasevapractica.comportamiento_dato5, comportamiento_dato6: @personasevapractica.comportamiento_dato6, comportamiento_dato7: @personasevapractica.comportamiento_dato7, comportamiento_dato8: @personasevapractica.comportamiento_dato8, comportamiento_dato9: @personasevapractica.comportamiento_dato9, conocimiento_dato10: @personasevapractica.conocimiento_dato10, conocimiento_dato1: @personasevapractica.conocimiento_dato1, conocimiento_dato2: @personasevapractica.conocimiento_dato2, conocimiento_dato3: @personasevapractica.conocimiento_dato3, conocimiento_dato4: @personasevapractica.conocimiento_dato4, conocimiento_dato5: @personasevapractica.conocimiento_dato5, conocimiento_dato6: @personasevapractica.conocimiento_dato6, conocimiento_dato7: @personasevapractica.conocimiento_dato7, conocimiento_dato8: @personasevapractica.conocimiento_dato8, conocimiento_dato9: @personasevapractica.conocimiento_dato9, destreza_dato10: @personasevapractica.destreza_dato10, destreza_dato11: @personasevapractica.destreza_dato11, destreza_dato12: @personasevapractica.destreza_dato12, destreza_dato13: @personasevapractica.destreza_dato13, destreza_dato14: @personasevapractica.destreza_dato14, destreza_dato15: @personasevapractica.destreza_dato15, destreza_dato1: @personasevapractica.destreza_dato1, destreza_dato2: @personasevapractica.destreza_dato2, destreza_dato3: @personasevapractica.destreza_dato3, destreza_dato4: @personasevapractica.destreza_dato4, destreza_dato5: @personasevapractica.destreza_dato5, destreza_dato6: @personasevapractica.destreza_dato6, destreza_dato7: @personasevapractica.destreza_dato7, destreza_dato8: @personasevapractica.destreza_dato8, destreza_dato9: @personasevapractica.destreza_dato9, evaluacion: @personasevapractica.evaluacion, observaciones: @personasevapractica.observaciones, persona_id: @personasevapractica.persona_id, personastramite_id: @personasevapractica.personastramite_id, puntaje_comportamiento: @personasevapractica.puntaje_comportamiento, puntaje_conocimiento: @personasevapractica.puntaje_conocimiento, puntaje_destreza: @personasevapractica.puntaje_destreza, total: @personasevapractica.total, total_comportamiento: @personasevapractica.total_comportamiento, total_conocimiento: @personasevapractica.total_conocimiento, total_destreza: @personasevapractica.total_destreza, user_id: @personasevapractica.user_id } }
    assert_redirected_to personasevapractica_url(@personasevapractica)
  end

  test "should destroy personasevapractica" do
    assert_difference('Personasevapractica.count', -1) do
      delete personasevapractica_url(@personasevapractica)
    end

    assert_redirected_to personasevapracticas_url
  end
end
