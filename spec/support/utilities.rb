include ApplicationHelper

def log_in(user, options={})
	if options[:no_capybara]
		# Sign in when not using Capybara.
		remember_token = User.new_remember_token
		cookies[:remember_token] =remember_token
		user.update_attribute( :remember_token, User.encrypt(remember_token) )
	else
		visit signin_path
		fill_in "Email", 		with: user.email
		fill_in "Password", with: user.password
		click_button "Sign in"
	end
end

def log_in_admin(admin)
	visit new_admin_user_session_path
	fill_in "Email",    with: admin.email
	fill_in "Password", with: admin.password
	click_button "Login"
end
