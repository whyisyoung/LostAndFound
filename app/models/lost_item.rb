class LostItem < ActiveRecord::Base
  attr_accessible :category_id, :detail, :finder, :lost_time, :phone, :place, :status, :user_id

  validates :lost_time, :detail, :finder, :place, :user_id, presence: true

  VALID_PHONE_REGEX = /\A(13[0-9]|15[012356789]|18[0236789]|14[57])[0-9]{8}\z/
  validates :phone,  length: { is: 11, message: "phone number should be 11 digits!" },
  								 	 format: { with: VALID_PHONE_REGEX },
  								 	 allow_blank: true

end
