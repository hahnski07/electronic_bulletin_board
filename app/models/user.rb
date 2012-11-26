class User < ActiveRecord::Base
	attr_accessible :email, :name, :password, :password_confirmation
	has_secure_password
  
	has_many :boards
	has_many :advertisements
	has_many :payment_details
  
	before_save { self.email.downcase! }
	before_save :create_remember_token
  
	validates :name, presence: true
	validates :email, presence: true, format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i }, uniqueness: { case_sensitive: false }
	validates :password, presence: true, length: { minimum: 6 } 
	validates :password_confirmation, presence: true
  
	def admin?
		self.admin
	end
	
	private
		def create_remember_token
			self.remember_token = SecureRandom.urlsafe_base64
		end
end
