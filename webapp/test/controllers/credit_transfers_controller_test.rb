require 'test_helper'

class CreditTransfersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @credit_transfer = credit_transfers(:one)
  end

  test "should get index" do
    get credit_transfers_url
    assert_response :success
  end

  test "should get new" do
    get new_credit_transfer_url
    assert_response :success
  end

  test "should create credit_transfer" do
    assert_difference('CreditTransfer.count') do
      post credit_transfers_url, params: { credit_transfer: {  } }
    end

    assert_redirected_to credit_transfer_url(CreditTransfer.last)
  end

  test "should show credit_transfer" do
    get credit_transfer_url(@credit_transfer)
    assert_response :success
  end

  test "should get edit" do
    get edit_credit_transfer_url(@credit_transfer)
    assert_response :success
  end

  test "should update credit_transfer" do
    patch credit_transfer_url(@credit_transfer), params: { credit_transfer: {  } }
    assert_redirected_to credit_transfer_url(@credit_transfer)
  end

  test "should destroy credit_transfer" do
    assert_difference('CreditTransfer.count', -1) do
      delete credit_transfer_url(@credit_transfer)
    end

    assert_redirected_to credit_transfers_url
  end
end
