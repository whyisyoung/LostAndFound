module SessionsHelper

	def sign_in(user)
		remember_token = User.new_remember_token
		cookies.permanent[:remember_token] = remember_token
		user.update_attribute(:remember_token, User.encrypt(remember_token))
		self.current_signed_in_user = user
	end

	def signed_in?
		!current_signed_in_user.nil?
	end

	def sign_out
		cookies.delete(:remember_token)
		self.current_signed_in_user = nil
	end

	def current_signed_in_user=(user)
		@current_signed_in_user = user
	end

	def current_signed_in_user
		remember_token = User.encrypt(cookies[:remember_token])
		@current_signed_in_user ||= User.find_by_remember_token(remember_token)
	end

	def current_signed_in_user?(user)
		user == current_signed_in_user
	end

	def user_has_signed_in
    unless signed_in?
      store_wanted_location
      redirect_to signin_url, notice: 'Please sign in.'
    end
  end

	def redirect_back_or(default)
		redirect_to(session[:return_to] || default)
		session.delete(:return_to)
	end

	def store_wanted_location
		session[:return_to] =request.fullpath
	end
end
