class Employee < ApplicationRecord
  has_many :trainingevents
  has_many :trainingevents, through: :eventattendees

  has_many :roles
  has_many :roles, through: :employeeroles
end
