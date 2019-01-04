class Applicationuserinrole < ApplicationRecord
  belongs_to :applicationuser
  belongs_to :applicationrole
  
  attr_accessor :email, :role_id
  
  validates :applicationuser_id, :presence => true
  validates :applicationrole_id, :presence => true
end
