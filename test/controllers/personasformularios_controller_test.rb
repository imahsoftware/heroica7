require 'test_helper'

class PersonasformulariosControllerTest < ActionDispatch::IntegrationTest
  setup do
    @personasformulario = personasformularios(:one)
  end

  test "should get index" do
    get personasformularios_url
    assert_response :success
  end

  test "should get new" do
    get new_personasformulario_url
    assert_response :success
  end

  test "should create personasformulario" do
    assert_difference('Personasformulario.count') do
      post personasformularios_url, params: { personasformulario: { autobuscar: @personasformulario.autobuscar, barrio: @personasformulario.barrio, celular: @personasformulario.celular, direccion: @personasformulario.direccion, discapacidad: @personasformulario.discapacidad, documento: @personasformulario.documento, email: @personasformulario.email, estado_civil: @personasformulario.estado_civil, estrato: @personasformulario.estrato, factor: @personasformulario.factor, fecha_nacimiento: @personasformulario.fecha_nacimiento, genero: @personasformulario.genero, id_evial: @personasformulario.id_evial, identificacion: @personasformulario.identificacion, jornada: @personasformulario.jornada, lugar_nacimiento: @personasformulario.lugar_nacimiento, lugar_origen: @personasformulario.lugar_origen, multi_afro: @personasformulario.multi_afro, multi_cabeza: @personasformulario.multi_cabeza, multi_desplazado: @personasformulario.multi_desplazado, multi_indigena: @personasformulario.multi_indigena, multi_pobfrontera: @personasformulario.multi_pobfrontera, multi_pobroom: @personasformulario.multi_pobroom, multi_reinsertado: @personasformulario.multi_reinsertado, municipio_id: @personasformulario.municipio_id, nivel_formacion: @personasformulario.nivel_formacion, nombre: @personasformulario.nombre, ocupacion: @personasformulario.ocupacion, portafolio_id: @personasformulario.portafolio_id, primer_apellido: @personasformulario.primer_apellido, primer_nombre: @personasformulario.primer_nombre, regimen: @personasformulario.regimen, rh: @personasformulario.rh, segundo_apellido: @personasformulario.segundo_apellido, segundo_nombre: @personasformulario.segundo_nombre, telefono: @personasformulario.telefono, telefono_oficina: @personasformulario.telefono_oficina } }
    end

    assert_redirected_to personasformulario_url(Personasformulario.last)
  end

  test "should show personasformulario" do
    get personasformulario_url(@personasformulario)
    assert_response :success
  end

  test "should get edit" do
    get edit_personasformulario_url(@personasformulario)
    assert_response :success
  end

  test "should update personasformulario" do
    patch personasformulario_url(@personasformulario), params: { personasformulario: { autobuscar: @personasformulario.autobuscar, barrio: @personasformulario.barrio, celular: @personasformulario.celular, direccion: @personasformulario.direccion, discapacidad: @personasformulario.discapacidad, documento: @personasformulario.documento, email: @personasformulario.email, estado_civil: @personasformulario.estado_civil, estrato: @personasformulario.estrato, factor: @personasformulario.factor, fecha_nacimiento: @personasformulario.fecha_nacimiento, genero: @personasformulario.genero, id_evial: @personasformulario.id_evial, identificacion: @personasformulario.identificacion, jornada: @personasformulario.jornada, lugar_nacimiento: @personasformulario.lugar_nacimiento, lugar_origen: @personasformulario.lugar_origen, multi_afro: @personasformulario.multi_afro, multi_cabeza: @personasformulario.multi_cabeza, multi_desplazado: @personasformulario.multi_desplazado, multi_indigena: @personasformulario.multi_indigena, multi_pobfrontera: @personasformulario.multi_pobfrontera, multi_pobroom: @personasformulario.multi_pobroom, multi_reinsertado: @personasformulario.multi_reinsertado, municipio_id: @personasformulario.municipio_id, nivel_formacion: @personasformulario.nivel_formacion, nombre: @personasformulario.nombre, ocupacion: @personasformulario.ocupacion, portafolio_id: @personasformulario.portafolio_id, primer_apellido: @personasformulario.primer_apellido, primer_nombre: @personasformulario.primer_nombre, regimen: @personasformulario.regimen, rh: @personasformulario.rh, segundo_apellido: @personasformulario.segundo_apellido, segundo_nombre: @personasformulario.segundo_nombre, telefono: @personasformulario.telefono, telefono_oficina: @personasformulario.telefono_oficina } }
    assert_redirected_to personasformulario_url(@personasformulario)
  end

  test "should destroy personasformulario" do
    assert_difference('Personasformulario.count', -1) do
      delete personasformulario_url(@personasformulario)
    end

    assert_redirected_to personasformularios_url
  end
end
