require 'test_helper'

class VerificationCodesControllerTest < ActionController::TestCase
  setup do
    @verification_code = verification_codes(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:verification_codes)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create verification_code" do
    assert_difference('VerificationCode.count') do
      post :create, verification_code: { apartment_id: @verification_code.apartment_id, user_id: @verification_code.user_id }
    end

    assert_redirected_to verification_code_path(assigns(:verification_code))
  end

  test "should show verification_code" do
    get :show, id: @verification_code
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @verification_code
    assert_response :success
  end

  test "should update verification_code" do
    patch :update, id: @verification_code, verification_code: { apartment_id: @verification_code.apartment_id, user_id: @verification_code.user_id }
    assert_redirected_to verification_code_path(assigns(:verification_code))
  end

  test "should destroy verification_code" do
    assert_difference('VerificationCode.count', -1) do
      delete :destroy, id: @verification_code
    end

    assert_redirected_to verification_codes_path
  end
end
