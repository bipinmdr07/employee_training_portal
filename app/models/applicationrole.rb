class Applicationrole < ApplicationRecord
  has_many :applicationuserinroles
  has_many :applicationusers, through: :applicationuserinroles
  
  validates :applicationrolename, :presence => true
end
