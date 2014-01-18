ActiveAdmin.register Category do
	menu :priority => 3
	index do
		selectable_column
		column :id do |category|
			link_to category.id, admin_category_path(category)
		end
		column :name
		default_actions
	end
end
