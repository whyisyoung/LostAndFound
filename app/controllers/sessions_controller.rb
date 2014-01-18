class SessionsController < ApplicationController
	include Utility

	before_filter :signed_in_user_cannot_visit_signin_or_signup,
								only: [:new, :create]

	def new
	end

	def create
		user = User.find_by_email(params[:session][:email].downcase)
		if user && user.authenticate(params[:session][:password])
			log_in user
			redirect_back_or user
		else
			flash.now[:error] = 'Invalid email/password combination'
			render 'new'
		end
	end

	def destroy
		sign_out
		redirect_to root_path
	end

end
