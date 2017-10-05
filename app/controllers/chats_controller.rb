class ChatsController < ApplicationController

  before_action :confirm_logged_in

  def myChats
    log("myChats")
  	#@myChats = Chat.all
    @myChats = Chat.search_u_A(session[:user_id])
    @myChats += Chat.search_u_B(session[:user_id])


    #insert list of chats.
    #then it returns a map based on the chats with the other names

    #map for each user with name
    @users = Hash.new
    @usernames = Hash.new
    @myChats.each do |c|
      if !@users.key?(c.userA_id)
        @users[c.userA_id] = User.where(:id => c.userA_id).first
      end

      if !@users.key?(c.userB_id)
        @users[c.userB_id] = User.where(:id => c.userB_id).first
      end

      if iam(c.userA_id)
        otherUsername = @users[c.userB_id].username
      else
        otherUsername = @users[c.userA_id].username
      end
      @usernames[c] = otherUsername

    end
  end

  

  def iam(user_id)
    return user_id == session[:user_id]
  end

  def chatWith
    log("chatWith")
    begin
        @chat = Chat.find(params[:id])
    rescue Exception
        @chat = Chat.find(params[:chat_id])
    end
      
    @chat_id = @chat.id
    @messages = Message.where(:chat_id => @chat_id)
    @sender = Hash.new
    usernames = Hash.new

    @messages.each do |m|
      if !usernames.key?(m.user_id)
        usernames[m.user_id] = User.find(m.user_id).username
      end
      @sender[m] = usernames[m.user_id]
    end

    #others: .order("last_name ASC").limit(5)
    #        .include(:articles_authored)
    #       .find_by_id(2)
    #        .find_by_name("abc")
    #        .find(2)    // this is for when you know it's in DB
    #         .all
    #         .first
    #         .last
  end

  def sendMessage
  	#Find existing using form parameters
    @message = Message.new(messageParams)
    @message.user_id = session[:user_id]

    @chat = Chat.find(params[:chat_id])
    @chat.messages << @message

    #save succeed, redirect
    redirect_to(:action => 'chatWith', :chat_id => params[:chat_id])
   
  end

   private
    def messageParams
      params.require(:message).permit(:message, :chat_id)
    end
end
