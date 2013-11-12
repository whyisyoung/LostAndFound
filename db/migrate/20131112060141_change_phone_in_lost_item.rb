class ChangePhoneInLostItem < ActiveRecord::Migration
  def up
  	change_column :lost_items, :phone, :integer, limit: 8
  end

  def down
  	change_column :lost_items, :phone, :integer
  end
end
