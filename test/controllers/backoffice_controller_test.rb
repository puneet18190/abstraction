require 'test_helper'

class BackofficeControllerTest < ActionDispatch::IntegrationTest
  test "should get GenerateInvites" do
    get backoffice_GenerateInvites_url
    assert_response :success
  end

  test "should get ABTesting" do
    get backoffice_ABTesting_url
    assert_response :success
  end

end
