require 'test_helper'

class AgendaspersonasControllerTest < ActionDispatch::IntegrationTest
  setup do
    @agendaspersona = agendaspersonas(:one)
  end

  test "should get index" do
    get agendaspersonas_url
    assert_response :success
  end

  test "should get new" do
    get new_agendaspersona_url
    assert_response :success
  end

  test "should create agendaspersona" do
    assert_difference('Agendaspersona.count') do
      post agendaspersonas_url, params: { agendaspersona: { agenda_id: @agendaspersona.agenda_id, persona_id: @agendaspersona.persona_id } }
    end

    assert_redirected_to agendaspersona_url(Agendaspersona.last)
  end

  test "should show agendaspersona" do
    get agendaspersona_url(@agendaspersona)
    assert_response :success
  end

  test "should get edit" do
    get edit_agendaspersona_url(@agendaspersona)
    assert_response :success
  end

  test "should update agendaspersona" do
    patch agendaspersona_url(@agendaspersona), params: { agendaspersona: { agenda_id: @agendaspersona.agenda_id, persona_id: @agendaspersona.persona_id } }
    assert_redirected_to agendaspersona_url(@agendaspersona)
  end

  test "should destroy agendaspersona" do
    assert_difference('Agendaspersona.count', -1) do
      delete agendaspersona_url(@agendaspersona)
    end

    assert_redirected_to agendaspersonas_url
  end
end
