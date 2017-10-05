require 'test_helper'

class ReputationControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get reputation_index_url
    assert_response :success
  end

  test "should get MyReputation" do
    get reputation_MyReputation_url
    assert_response :success
  end

  test "should get MyJudgements" do
    get reputation_MyJudgements_url
    assert_response :success
  end

end
