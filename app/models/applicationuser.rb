class Applicationuser < ApplicationRecord
  has_many :applicationuserinroles
  has_many :applicationroles, through: :applicationuserinroles
 
  has_secure_password
  before_save :encrypt_password
  after_save :clear_password
  
  attr_accessor :role_id
  
  validates :email, :presence => true
  validates :firstname, :presence => true
  validates :lastname, :presence => true
  validates :password, :presence => true
  validates :role_id, :presence => true

  def encrypt_password
    if password.present?
      self.salt = BCrypt::Engine.generate_salt
      self.password_digest= BCrypt::Engine.hash_secret(password, salt)
    end
  end
  
  def clear_password
    self.password = nil
  end
  
  def self.authenticate(username="", login_password="")
    user = Applicationuser.find_by(email: username)
   
    if user && user.match_password(login_password)
      return user
    else
      return false
    end
  end   
  
  def match_password(login_password="")
    password_digest == BCrypt::Engine.hash_secret(login_password, salt)
  end
  
  def self.get_id(username="")
    @appuser = Applicationuser.find_by(email: username)
	if(@appuser.nil?)
	  return false
	else
	  return @appuser.applicationuserid
	end
  end
end
