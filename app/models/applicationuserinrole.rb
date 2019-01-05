class Applicationuserinrole < ApplicationRecord
  attr_accessor :email, :role_id

  belongs_to :applicationuser
  belongs_to :applicationrole

  validates :applicationuser_id, presence: true
  validates :applicationrole_id, presence: true
end
