class User < ActiveRecord::Base
  has_many :lost_items, dependent: :destroy

  attr_accessible :email, :name, :password, :password_confirmation, :admin
  
  before_save { email.downcase! }
  before_create :create_remember_token

  validates :name, presence: true, length: { maximum: 20 }

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i
  validates :email, presence: true, 
  									format: { with: VALID_EMAIL_REGEX },
  									uniqueness: { case_sensitive: false }
  has_secure_password
  validates :password, length: { minimum: 6, maximum: 20 }, on: :create
  validates :password, length: { minimum: 6, maximum: 20 }, on: :update, unless: lambda{ |user| user.password.blank? }

  def User.new_remember_token
  	SecureRandom.urlsafe_base64
  end

  def User.encrypt( token )
  	Digest::SHA1.hexdigest( token.to_s )
  end

  private

  	def create_remember_token
  		self.remember_token = User.encrypt( User.new_remember_token )
  	end
end
