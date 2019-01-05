class Role < ApplicationRecord
  has_many :courses
  has_many :courses, through: :coursesforroles

  has_many :employees
  has_many :employees, through: :employeeroles

  validates :rolename, presence: true
end
