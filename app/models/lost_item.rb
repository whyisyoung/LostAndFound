class LostItem < ActiveRecord::Base
  attr_accessible :category_id, :detail, :finder, :lost_time, :phone, :place, :status, :user_id
end
