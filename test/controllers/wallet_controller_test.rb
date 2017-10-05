require 'test_helper'

class WalletControllerTest < ActionDispatch::IntegrationTest
  # test "should get send" do
  #   get wallet_send_url
  #   assert_response :success
  # end

  # test "should get withdraw" do
  #   get wallet_withdraw_url
  #   assert_response :success
  # end

  test "should get deposit" do
    get wallet_deposit_url
    assert_response :success
  end

  # test "should get transactions" do
  #   get wallet_transactions_url
  #   assert_response :success
  # end

end
