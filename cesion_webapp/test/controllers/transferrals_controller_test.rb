require 'test_helper'

class TransferralsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @transferral = transferrals(:one)
  end

  test "should get index" do
    get transferrals_url
    assert_response :success
  end

  test "should get new" do
    get new_transferral_url
    assert_response :success
  end

  test "should create transferral" do
    assert_difference('Transferral.count') do
      post transferrals_url, params: { transferral: {  } }
    end

    assert_redirected_to transferral_url(Transferral.last)
  end

  test "should show transferral" do
    get transferral_url(@transferral)
    assert_response :success
  end

  test "should get edit" do
    get edit_transferral_url(@transferral)
    assert_response :success
  end

  test "should update transferral" do
    patch transferral_url(@transferral), params: { transferral: {  } }
    assert_redirected_to transferral_url(@transferral)
  end

  test "should destroy transferral" do
    assert_difference('Transferral.count', -1) do
      delete transferral_url(@transferral)
    end

    assert_redirected_to transferrals_url
  end
end
