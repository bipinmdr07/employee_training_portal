class Course < ApplicationRecord
  attr_accessor :versionname, :emp_role_id
  has_many :roles
  has_many :roles, through: :coursesforroles

  has_many :versions
  has_many :versions, through: :courseversions

  validates :name, presence: true
  validates :description, presence: true
end
