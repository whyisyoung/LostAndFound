ActiveAdmin.register LostItem do
	menu :priority => 1
	scope :unclaimed
	index do
		selectable_column
		column :id do |item|
			link_to item.id, admin_lost_item_path(item)
		end
		columns_to_exclude = ["id", "created_at", "updated_at", "category_id", "user_id"]
	    (LostItem.column_names - columns_to_exclude).each do |c|
	      column c.to_sym
	    end
	    default_actions
	end
end
