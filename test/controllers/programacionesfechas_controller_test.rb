require 'test_helper'

class ProgramacionesfechasControllerTest < ActionDispatch::IntegrationTest
  setup do
    @programacionesfecha = programacionesfechas(:one)
  end

  test "should get index" do
    get programacionesfechas_url
    assert_response :success
  end

  test "should get new" do
    get new_programacionesfecha_url
    assert_response :success
  end

  test "should create programacionesfecha" do
    assert_difference('Programacionesfecha.count') do
      post programacionesfechas_url, params: { programacionesfecha: { estado10: @programacionesfecha.estado10, estado11: @programacionesfecha.estado11, estado12: @programacionesfecha.estado12, estado13: @programacionesfecha.estado13, estado14: @programacionesfecha.estado14, estado15: @programacionesfecha.estado15, estado16: @programacionesfecha.estado16, estado17: @programacionesfecha.estado17, estado1: @programacionesfecha.estado1, estado2: @programacionesfecha.estado2, estado3: @programacionesfecha.estado3, estado4: @programacionesfecha.estado4, estado5: @programacionesfecha.estado5, estado6: @programacionesfecha.estado6, estado7: @programacionesfecha.estado7, estado8: @programacionesfecha.estado8, estado9: @programacionesfecha.estado9, fecha: @programacionesfecha.fecha, hora10: @programacionesfecha.hora10, hora11: @programacionesfecha.hora11, hora12: @programacionesfecha.hora12, hora13: @programacionesfecha.hora13, hora14: @programacionesfecha.hora14, hora15: @programacionesfecha.hora15, hora16: @programacionesfecha.hora16, hora17: @programacionesfecha.hora17, hora1: @programacionesfecha.hora1, hora2: @programacionesfecha.hora2, hora3: @programacionesfecha.hora3, hora4: @programacionesfecha.hora4, hora5: @programacionesfecha.hora5, hora6: @programacionesfecha.hora6, hora7: @programacionesfecha.hora7, hora8: @programacionesfecha.hora8, hora9: @programacionesfecha.hora9, placa_id: @programacionesfecha.placa_id } }
    end

    assert_redirected_to programacionesfecha_url(Programacionesfecha.last)
  end

  test "should show programacionesfecha" do
    get programacionesfecha_url(@programacionesfecha)
    assert_response :success
  end

  test "should get edit" do
    get edit_programacionesfecha_url(@programacionesfecha)
    assert_response :success
  end

  test "should update programacionesfecha" do
    patch programacionesfecha_url(@programacionesfecha), params: { programacionesfecha: { estado10: @programacionesfecha.estado10, estado11: @programacionesfecha.estado11, estado12: @programacionesfecha.estado12, estado13: @programacionesfecha.estado13, estado14: @programacionesfecha.estado14, estado15: @programacionesfecha.estado15, estado16: @programacionesfecha.estado16, estado17: @programacionesfecha.estado17, estado1: @programacionesfecha.estado1, estado2: @programacionesfecha.estado2, estado3: @programacionesfecha.estado3, estado4: @programacionesfecha.estado4, estado5: @programacionesfecha.estado5, estado6: @programacionesfecha.estado6, estado7: @programacionesfecha.estado7, estado8: @programacionesfecha.estado8, estado9: @programacionesfecha.estado9, fecha: @programacionesfecha.fecha, hora10: @programacionesfecha.hora10, hora11: @programacionesfecha.hora11, hora12: @programacionesfecha.hora12, hora13: @programacionesfecha.hora13, hora14: @programacionesfecha.hora14, hora15: @programacionesfecha.hora15, hora16: @programacionesfecha.hora16, hora17: @programacionesfecha.hora17, hora1: @programacionesfecha.hora1, hora2: @programacionesfecha.hora2, hora3: @programacionesfecha.hora3, hora4: @programacionesfecha.hora4, hora5: @programacionesfecha.hora5, hora6: @programacionesfecha.hora6, hora7: @programacionesfecha.hora7, hora8: @programacionesfecha.hora8, hora9: @programacionesfecha.hora9, placa_id: @programacionesfecha.placa_id } }
    assert_redirected_to programacionesfecha_url(@programacionesfecha)
  end

  test "should destroy programacionesfecha" do
    assert_difference('Programacionesfecha.count', -1) do
      delete programacionesfecha_url(@programacionesfecha)
    end

    assert_redirected_to programacionesfechas_url
  end
end
