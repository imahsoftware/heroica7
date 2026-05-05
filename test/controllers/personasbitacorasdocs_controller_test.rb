require 'test_helper'

class PersonasbitacorasdocsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @personasbitacorasdoc = personasbitacorasdocs(:one)
  end

  test "should get index" do
    get personasbitacorasdocs_url
    assert_response :success
  end

  test "should get new" do
    get new_personasbitacorasdoc_url
    assert_response :success
  end

  test "should create personasbitacorasdoc" do
    assert_difference('Personasbitacorasdoc.count') do
      post personasbitacorasdocs_url, params: { personasbitacorasdoc: { captura: @personasbitacorasdoc.captura, personasbitacora_id: @personasbitacorasdoc.personasbitacora_id, user_id: @personasbitacorasdoc.user_id } }
    end

    assert_redirected_to personasbitacorasdoc_url(Personasbitacorasdoc.last)
  end

  test "should show personasbitacorasdoc" do
    get personasbitacorasdoc_url(@personasbitacorasdoc)
    assert_response :success
  end

  test "should get edit" do
    get edit_personasbitacorasdoc_url(@personasbitacorasdoc)
    assert_response :success
  end

  test "should update personasbitacorasdoc" do
    patch personasbitacorasdoc_url(@personasbitacorasdoc), params: { personasbitacorasdoc: { captura: @personasbitacorasdoc.captura, personasbitacora_id: @personasbitacorasdoc.personasbitacora_id, user_id: @personasbitacorasdoc.user_id } }
    assert_redirected_to personasbitacorasdoc_url(@personasbitacorasdoc)
  end

  test "should destroy personasbitacorasdoc" do
    assert_difference('Personasbitacorasdoc.count', -1) do
      delete personasbitacorasdoc_url(@personasbitacorasdoc)
    end

    assert_redirected_to personasbitacorasdocs_url
  end
end
