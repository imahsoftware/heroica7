require 'test_helper'

class EncuestaspreopcionesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @encuestaspreopcion = encuestaspreopciones(:one)
  end

  test "should get index" do
    get encuestaspreopciones_url
    assert_response :success
  end

  test "should get new" do
    get new_encuestaspreopcion_url
    assert_response :success
  end

  test "should create encuestaspreopcion" do
    assert_difference('Encuestaspreopcion.count') do
      post encuestaspreopciones_url, params: { encuestaspreopcion: { clase: @encuestaspreopcion.clase, encuestaspregunta: @encuestaspreopcion.encuestaspregunta, foto: @encuestaspreopcion.foto, respuesta: @encuestaspreopcion.respuesta } }
    end

    assert_redirected_to encuestaspreopcion_url(Encuestaspreopcion.last)
  end

  test "should show encuestaspreopcion" do
    get encuestaspreopcion_url(@encuestaspreopcion)
    assert_response :success
  end

  test "should get edit" do
    get edit_encuestaspreopcion_url(@encuestaspreopcion)
    assert_response :success
  end

  test "should update encuestaspreopcion" do
    patch encuestaspreopcion_url(@encuestaspreopcion), params: { encuestaspreopcion: { clase: @encuestaspreopcion.clase, encuestaspregunta: @encuestaspreopcion.encuestaspregunta, foto: @encuestaspreopcion.foto, respuesta: @encuestaspreopcion.respuesta } }
    assert_redirected_to encuestaspreopcion_url(@encuestaspreopcion)
  end

  test "should destroy encuestaspreopcion" do
    assert_difference('Encuestaspreopcion.count', -1) do
      delete encuestaspreopcion_url(@encuestaspreopcion)
    end

    assert_redirected_to encuestaspreopciones_url
  end
end
