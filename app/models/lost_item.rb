class LostItem < ActiveRecord::Base
  belongs_to :user
  belongs_to :category

  acts_as_commentable

  attr_accessible :category_id, :detail, :finder, :lost_time,
                  :phone, :place, :status, :user_id, :photo

  before_save { status = 'unclaimed' }

  has_attached_file :photo, styles: { medium: "300*300>", thumb: "150*150>" }
  validates_attachment :photo,
                       :content_type => { :content_type => ["image/jpg", "image/jpeg", "image/gif", "image/png"] },
                       :size => { in: 0..4.megabytes }

  validates :lost_time, :detail, :finder, :place, :user_id, presence: true

  VALID_PHONE_REGEX = /\A(13[0-9]|15[012356789]|18[0236789]|14[57])[0-9]{8}\z/
  validates :phone,  length: { is: 11,
                               message: 'Phone number should be 11 digits!' },
                     format: { with: VALID_PHONE_REGEX },
                     allow_blank: true

  validates :category_id, inclusion: { in: 1..6 }

  default_scope -> { order 'lost_time DESC' }
  scope :unclaimed, where(status: 'unclaimed')


  def self.show_page(page)
    paginate :per_page => 15, :page => page,
    :order => 'lost_time DESC'
  end

end
