require 'test_helper'

class EjecucionesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @ejecucion = ejecuciones(:one)
  end

  test "should get index" do
    get ejecuciones_url
    assert_response :success
  end

  test "should get new" do
    get new_ejecucion_url
    assert_response :success
  end

  test "should create ejecucion" do
    assert_difference('Ejecucion.count') do
      post ejecuciones_url, params: { ejecucion: { controlador_metodo: @ejecucion.controlador_metodo, detalle: @ejecucion.detalle, ejecucion: @ejecucion.ejecucion, estado: @ejecucion.estado, fecha_cancelacion: @ejecucion.fecha_cancelacion, finejecucion: @ejecucion.finejecucion, idprocesamiento: @ejecucion.idprocesamiento, inicio: @ejecucion.inicio, observacion: @ejecucion.observacion, tipo: @ejecucion.tipo, user_cancela: @ejecucion.user_cancela, user_id: @ejecucion.user_id } }
    end

    assert_redirected_to ejecucion_url(Ejecucion.last)
  end

  test "should show ejecucion" do
    get ejecucion_url(@ejecucion)
    assert_response :success
  end

  test "should get edit" do
    get edit_ejecucion_url(@ejecucion)
    assert_response :success
  end

  test "should update ejecucion" do
    patch ejecucion_url(@ejecucion), params: { ejecucion: { controlador_metodo: @ejecucion.controlador_metodo, detalle: @ejecucion.detalle, ejecucion: @ejecucion.ejecucion, estado: @ejecucion.estado, fecha_cancelacion: @ejecucion.fecha_cancelacion, finejecucion: @ejecucion.finejecucion, idprocesamiento: @ejecucion.idprocesamiento, inicio: @ejecucion.inicio, observacion: @ejecucion.observacion, tipo: @ejecucion.tipo, user_cancela: @ejecucion.user_cancela, user_id: @ejecucion.user_id } }
    assert_redirected_to ejecucion_url(@ejecucion)
  end

  test "should destroy ejecucion" do
    assert_difference('Ejecucion.count', -1) do
      delete ejecucion_url(@ejecucion)
    end

    assert_redirected_to ejecuciones_url
  end
end
