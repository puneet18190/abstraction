class HomeController < ApplicationController

  before_action :confirm_logged_in

  def index
    log("index loaded")
  end



end
