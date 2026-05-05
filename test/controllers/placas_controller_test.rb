require 'test_helper'

class PlacasControllerTest < ActionDispatch::IntegrationTest
  setup do
    @placa = placas(:one)
  end

  test "should get index" do
    get placas_url
    assert_response :success
  end

  test "should get new" do
    get new_placa_url
    assert_response :success
  end

  test "should create placa" do
    assert_difference('Placa.count') do
      post placas_url, params: { placa: { cilindraje: @placa.cilindraje, descripcion: @placa.descripcion, estado: @placa.estado, instructor_id: @placa.instructor_id, linea: @placa.linea, liquidacion_fecha: @placa.liquidacion_fecha, liquidacion_nro: @placa.liquidacion_nro, marca: @placa.marca, modelo: @placa.modelo, motor: @placa.motor, nro_matricula: @placa.nro_matricula, observaciones: @placa.observaciones, pico_placa: @placa.pico_placa, pico_placan: @placa.pico_placan, picoyplaca: @placa.picoyplaca, portafolio_id: @placa.portafolio_id, propietario: @placa.propietario, revision_alerta: @placa.revision_alerta, revision_expedicion: @placa.revision_expedicion, revision_nro: @placa.revision_nro, revision_vencimiento: @placa.revision_vencimiento, serie: @placa.serie, soat_alerta: @placa.soat_alerta, soat_expedicion: @placa.soat_expedicion, soat_nro: @placa.soat_nro, soat_vencimiento: @placa.soat_vencimiento, tarjeta_alerta: @placa.tarjeta_alerta, tarjeta_expedicion: @placa.tarjeta_expedicion, tarjeta_nro: @placa.tarjeta_nro, tarjeta_vencimiento: @placa.tarjeta_vencimiento, tipo_vehiculo: @placa.tipo_vehiculo } }
    end

    assert_redirected_to placa_url(Placa.last)
  end

  test "should show placa" do
    get placa_url(@placa)
    assert_response :success
  end

  test "should get edit" do
    get edit_placa_url(@placa)
    assert_response :success
  end

  test "should update placa" do
    patch placa_url(@placa), params: { placa: { cilindraje: @placa.cilindraje, descripcion: @placa.descripcion, estado: @placa.estado, instructor_id: @placa.instructor_id, linea: @placa.linea, liquidacion_fecha: @placa.liquidacion_fecha, liquidacion_nro: @placa.liquidacion_nro, marca: @placa.marca, modelo: @placa.modelo, motor: @placa.motor, nro_matricula: @placa.nro_matricula, observaciones: @placa.observaciones, pico_placa: @placa.pico_placa, pico_placan: @placa.pico_placan, picoyplaca: @placa.picoyplaca, portafolio_id: @placa.portafolio_id, propietario: @placa.propietario, revision_alerta: @placa.revision_alerta, revision_expedicion: @placa.revision_expedicion, revision_nro: @placa.revision_nro, revision_vencimiento: @placa.revision_vencimiento, serie: @placa.serie, soat_alerta: @placa.soat_alerta, soat_expedicion: @placa.soat_expedicion, soat_nro: @placa.soat_nro, soat_vencimiento: @placa.soat_vencimiento, tarjeta_alerta: @placa.tarjeta_alerta, tarjeta_expedicion: @placa.tarjeta_expedicion, tarjeta_nro: @placa.tarjeta_nro, tarjeta_vencimiento: @placa.tarjeta_vencimiento, tipo_vehiculo: @placa.tipo_vehiculo } }
    assert_redirected_to placa_url(@placa)
  end

  test "should destroy placa" do
    assert_difference('Placa.count', -1) do
      delete placa_url(@placa)
    end

    assert_redirected_to placas_url
  end
end
