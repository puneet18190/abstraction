class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  layout "home_layout"
   private 
  def confirm_logged_in
  	unless session[:user_id]
  		flash[:notice] = "Please log in"
  		redirect_to(:controller => 'access', :action => 'login')
  		return false
  	end
  		return true
  	end
  
  def log(activity_name)
    #create new activity whenever the user does something
    if session[:user_id]
      user_id = session[:user_id]
    else 
      user_id = 0
    end
    act = UserActivity.new(:activity_name => activity_name, :user_id => user_id)
    act.save
  end
end
