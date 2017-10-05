class BackofficeController < ApplicationController
	before_action :confirm_logged_in


	def index
		log("backoffice loaded")
  	end


	def GenerateInvites
	end

	def ManageInvites
		@invites = Invite.where(:user_id => session[:user_id])
	end


 	def save_invite
 		invite = Invite.new(inviteParams)
 		invite.user_id = session[:user_id]
 		acc = AccessController.new
 		invite.invite_code = acc.generate_invite_code
 		invite.save
 		redirect_to(:action => 'index')
 	end



 	def inviteParams
      params.require(:invite).permit(:title, :comment)
 	end

end
