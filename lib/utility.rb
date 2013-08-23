require "sessions_helper"

module Utility
	
	def one_user_has_logged_in
    redirect_to(root_path) unless current_user.nil?
  end
end