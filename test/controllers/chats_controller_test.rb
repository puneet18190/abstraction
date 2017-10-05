require 'test_helper'

class ChatsControllerTest < ActionDispatch::IntegrationTest
  test "should get myChats" do
    get chats_myChats_url
    #assert_response :success
  end

  test "should get chatWith" do
    get chats_chatWith_url
    #assert_response :success
  end

end
