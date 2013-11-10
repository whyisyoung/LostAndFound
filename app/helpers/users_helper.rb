module UsersHelper

	# Returns the Gravatar (http://gravatar.com) for the given user.
	def gravatar_for( user, options = { size: 50, class: "gravatar" })
		gravatar_id = Digest::MD5::hexdigest( user.email.downcase )
		size = options[:size]
		style = options[:class]
		gravatar_url = "http://www.gravatar.com/avatar/#{gravatar_id}.png?s=#{size}"
		image_tag( gravatar_url, alt: user.name, class: style )
	end

	def edit_nothing_on_user?
		input_name         = params[:user][:name]
		input_email 			 = params[:user][:email]
		input_password 		 = params[:user][:password]
		input_confirmation = params[:user][:password_confirmation]
		(input_name == @user.name) && (input_email == @user.email) &&
					input_password.blank? && input_confirmation.blank?
	end

	# Allow user to leave password and confirmation blank when editing profile.
	# Just delete password or confirmation from user params.
	def delete_password_params_if_blank
		input_password     = params[:user][:password]
    input_confirmation = params[:user][:password_confirmation]
    if input_password.blank?
      params[:user].delete(:password)
      params[:user].delete(:password_confirmation) if input_confirmation.blank?
    else
      if input_confirmation.blank?
        params[:user].delete(:password)
      end
    end
	end

end
