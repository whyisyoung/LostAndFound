require "sessions_helper"

module Utility

	def signed_in_user_cannot_visit_signin_or_signup
    redirect_to(root_path) unless current_signed_in_user.nil?
  end
end