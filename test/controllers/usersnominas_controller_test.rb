require 'test_helper'

class UsersnominasControllerTest < ActionDispatch::IntegrationTest
  setup do
    @usersnomina = usersnominas(:one)
  end

  test "should get index" do
    get usersnominas_url
    assert_response :success
  end

  test "should get new" do
    get new_usersnomina_url
    assert_response :success
  end

  test "should create usersnomina" do
    assert_difference('Usersnomina.count') do
      post usersnominas_url, params: { usersnomina: { ajuste: @usersnomina.ajuste, auxilio: @usersnomina.auxilio, bonificacion: @usersnomina.bonificacion, dias: @usersnomina.dias, dotacion: @usersnomina.dotacion, horas_auto: @usersnomina.horas_auto, horas_bus: @usersnomina.horas_bus, horas_minus: @usersnomina.horas_minus, incapacidad: @usersnomina.incapacidad, observacion: @usersnomina.observacion, pension: @usersnomina.pension, periodosliquidacion_id: @usersnomina.periodosliquidacion_id, prestamo: @usersnomina.prestamo, quincena: @usersnomina.quincena, salario: @usersnomina.salario, salud: @usersnomina.salud, seguro: @usersnomina.seguro, subtotal: @usersnomina.subtotal, total: @usersnomina.total, user_id: @usersnomina.user_id } }
    end

    assert_redirected_to usersnomina_url(Usersnomina.last)
  end

  test "should show usersnomina" do
    get usersnomina_url(@usersnomina)
    assert_response :success
  end

  test "should get edit" do
    get edit_usersnomina_url(@usersnomina)
    assert_response :success
  end

  test "should update usersnomina" do
    patch usersnomina_url(@usersnomina), params: { usersnomina: { ajuste: @usersnomina.ajuste, auxilio: @usersnomina.auxilio, bonificacion: @usersnomina.bonificacion, dias: @usersnomina.dias, dotacion: @usersnomina.dotacion, horas_auto: @usersnomina.horas_auto, horas_bus: @usersnomina.horas_bus, horas_minus: @usersnomina.horas_minus, incapacidad: @usersnomina.incapacidad, observacion: @usersnomina.observacion, pension: @usersnomina.pension, periodosliquidacion_id: @usersnomina.periodosliquidacion_id, prestamo: @usersnomina.prestamo, quincena: @usersnomina.quincena, salario: @usersnomina.salario, salud: @usersnomina.salud, seguro: @usersnomina.seguro, subtotal: @usersnomina.subtotal, total: @usersnomina.total, user_id: @usersnomina.user_id } }
    assert_redirected_to usersnomina_url(@usersnomina)
  end

  test "should destroy usersnomina" do
    assert_difference('Usersnomina.count', -1) do
      delete usersnomina_url(@usersnomina)
    end

    assert_redirected_to usersnominas_url
  end
end
