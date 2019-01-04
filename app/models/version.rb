class Version < ApplicationRecord
  has_many :courses
  has_many :courses, through: :courseversions
  
  attr_accessor :course_id
  
  validates :versionname, :presence => true
end
