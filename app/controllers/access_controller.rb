class AccessController < ApplicationController


  before_action :confirm_logged_in, :except => [:login, 
    :attempt_login, :logout, :signup, :attempt_signup, :verify_email, :verify_email_code]

  def signup
  end

 def attempt_signup
  	if params[:username].present? && params[:password].present? 

      user = User.new(:username => params[:username], 
      :password => params[:password],
          # :email => params[:email],
          #:signup_code => params[:signup_code], 
      :verify_email_code => generate_email_code)



      if params[:email].present?
        log("signup using email #{params[:email]}")
        user.email = params[:email]
      end

      if params[:signup_code].present?
        if is_invite_valid(params[:signup_code])  
          log("Using valid signup_code")
          user.signup_code = params[:signup_code]
        else
          log("Trying signup without valid invite code")
          flash[:notice] = "The signup code you used was not recognized. Please try again."
          redirect_to(:action => 'signup')
        end
      end

      user.save

      invite = Invite.new(:user_id => user.id, 
        :invite_code => generate_invite_code, :title => "default", :comment => "signup generated")
      invite.save

      #TODO
      #start chat with support
      supportChat = Chat.new(:userA_id => 1, :userB_id => user.id)
      supportChat.save

      text = "This is a chat with support. 
      Please contact us at any time using this chat, 
      or by email: civilization@protonmail.com"

      supportMessage = Message.new(:message => text, :user_id => 1)
      supportChat.messages << supportMessage
      log("Successfully signed up user #{user.id}")
  		flash[:notice] = "New user #{params[:username]} successfully saved. You can now log in."
  		redirect_to(:action => 'login')

    else 
  	 flash[:notice] = "You need to fill in all fields for this to work."
     redirect_to(:action => 'signup')
    end
  end

  def verify_email
    puts params[:email_code]

    user = User.where(:verify_email_code => params[:email_code]).first
    if !user.nil?
      if user.is_email_verified?
        flash[:notice] = "User already verified. Thank you."
        redirect_to(:action => 'login')
      else
        #On verification, make a small payment to the user.
        user.is_email_verified = true
        user.save

        log("Generating P0.5 for verification")
        tx = Transaction.new
        tx.from_user = 2
        tx.to_user = session[:user_id]
        tx.text_amo = "0.5"
        conv = Converter.new
        tx.amount = conv.to_i(tx.text_amo)
        tx.save
        log("Verification of email tx saved")
        flash[:notice] = "Successfully verified email."
        redirect_to(:action => 'login')
      end
    else
      log("Verification code for email not recognized")
      flash[:notice] = "Code not recognized. Please try again"
      redirect_to(:action => 'login')
    end
  end

  def startSupportChat
  end

  def is_invite_valid(signup_code)
    invite = Invite.where(:invite_code => signup_code).first
    #userNotNull = User.where(:invite_code => signup_code).first
    if invite
      return true
    else
      return false
    end
  end

  def generate_invite_code
    toCheckInDB = random_hash[0,4]
    invite = Invite.where(:invite_code => toCheckInDB).first
    #userShouldBeNull = User.where(:invite_code => toCheckInDB).first

    if !invite
      result = toCheckInDB
    else
      result = generate_invite_code
    end
   return result
  end

  def random_hash
    wantedChars = "23456789ABCDEFGHJKLMNPRSTUVWXYZabcdefghijkmnpqrstuvwxyz"
    random = string_shuffle(wantedChars+wantedChars+wantedChars)
    return random
  end


  def generate_email_code
    email_code = random_hash[0,7]
    return email_code
  end

  def string_shuffle(s)
    s.split("").shuffle.join
  end

  def login
  end
  
  def attempt_login
  		  	
  	if params[:username].present? && params[:password].present?

  		found_user = 
  			User.where(:username => params[:username])
  			.where(:password => params[:password]).first
  		if found_user
  			authorized_user = found_user
  		end
  	end
  	if authorized_user
  		session[:user_id] = authorized_user.id
  		session[:username] = authorized_user.username
      invite = Invite.where(:user_id => authorized_user.id).first
      session[:invite_code] = invite.invite_code

  		redirect_to(:controller => 'home', :action => 'index')
  	else
  		flash[:notice] = "Invalid username/password combination"
  		redirect_to(:action => 'login')
  	end
  end

  def logout
    log("logout")
  	session[:user_id] = nil
  	session[:username] = nil
	  flash[:notice] = "Logged out"
  	redirect_to(:action => 'login')
  end



end
