ActiveAdmin.register User do
	menu :priority => 2
	#batch_action :destroy, :confirm => "Are you sure you want to delete all of these?" do |selection|
	#	User.destroy(selection)
	#	redirect_to(admin_users_path)
	#end
	index do
		selectable_column
		column :id do |user|
			link_to user.id, admin_user_path(user)
		end
		column :name
		column :email
		column "Update Time", :updated_at
		default_actions
	end
end
