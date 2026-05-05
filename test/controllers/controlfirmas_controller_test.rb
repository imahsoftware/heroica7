require 'test_helper'

class ControlfirmasControllerTest < ActionDispatch::IntegrationTest
  setup do
    @controlfirma = controlfirmas(:one)
  end

  test "should get index" do
    get controlfirmas_url
    assert_response :success
  end

  test "should get new" do
    get new_controlfirma_url
    assert_response :success
  end

  test "should create controlfirma" do
    assert_difference('Controlfirma.count') do
      post controlfirmas_url, params: { controlfirma: { codigo_firma: @controlfirma.codigo_firma, codigo_otp2: @controlfirma.codigo_otp2, codigo_otp: @controlfirma.codigo_otp, controlador: @controlfirma.controlador, estado: @controlfirma.estado, fecha_firma: @controlfirma.fecha_firma, id_registro: @controlfirma.id_registro, modelo: @controlfirma.modelo, portafolio_id: @controlfirma.portafolio_id, respuesta_otp2: @controlfirma.respuesta_otp2, respuesta_otp: @controlfirma.respuesta_otp, tipo_documento: @controlfirma.tipo_documento, url: @controlfirma.url } }
    end

    assert_redirected_to controlfirma_url(Controlfirma.last)
  end

  test "should show controlfirma" do
    get controlfirma_url(@controlfirma)
    assert_response :success
  end

  test "should get edit" do
    get edit_controlfirma_url(@controlfirma)
    assert_response :success
  end

  test "should update controlfirma" do
    patch controlfirma_url(@controlfirma), params: { controlfirma: { codigo_firma: @controlfirma.codigo_firma, codigo_otp2: @controlfirma.codigo_otp2, codigo_otp: @controlfirma.codigo_otp, controlador: @controlfirma.controlador, estado: @controlfirma.estado, fecha_firma: @controlfirma.fecha_firma, id_registro: @controlfirma.id_registro, modelo: @controlfirma.modelo, portafolio_id: @controlfirma.portafolio_id, respuesta_otp2: @controlfirma.respuesta_otp2, respuesta_otp: @controlfirma.respuesta_otp, tipo_documento: @controlfirma.tipo_documento, url: @controlfirma.url } }
    assert_redirected_to controlfirma_url(@controlfirma)
  end

  test "should destroy controlfirma" do
    assert_difference('Controlfirma.count', -1) do
      delete controlfirma_url(@controlfirma)
    end

    assert_redirected_to controlfirmas_url
  end
end
