require 'test_helper'

class PersonasclasesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @personasclase = personasclases(:one)
  end

  test "should get index" do
    get personasclases_url
    assert_response :success
  end

  test "should get new" do
    get new_personasclase_url
    assert_response :success
  end

  test "should create personasclase" do
    assert_difference('Personasclase.count') do
      post personasclases_url, params: { personasclase: { fecha_clase: @personasclase.fecha_clase, instructor_id: @personasclase.instructor_id, persona_id: @personasclase.persona_id, placa_id: @personasclase.placa_id, recoje: @personasclase.recoje, tiposhorario_id: @personasclase.tiposhorario_id, user_id: @personasclase.user_id } }
    end

    assert_redirected_to personasclase_url(Personasclase.last)
  end

  test "should show personasclase" do
    get personasclase_url(@personasclase)
    assert_response :success
  end

  test "should get edit" do
    get edit_personasclase_url(@personasclase)
    assert_response :success
  end

  test "should update personasclase" do
    patch personasclase_url(@personasclase), params: { personasclase: { fecha_clase: @personasclase.fecha_clase, instructor_id: @personasclase.instructor_id, persona_id: @personasclase.persona_id, placa_id: @personasclase.placa_id, recoje: @personasclase.recoje, tiposhorario_id: @personasclase.tiposhorario_id, user_id: @personasclase.user_id } }
    assert_redirected_to personasclase_url(@personasclase)
  end

  test "should destroy personasclase" do
    assert_difference('Personasclase.count', -1) do
      delete personasclase_url(@personasclase)
    end

    assert_redirected_to personasclases_url
  end
end
