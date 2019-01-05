class Version < ApplicationRecord
  attr_accessor :course_id

  has_many :courses
  has_many :courses, through: :courseversions

  validates :versionname, :presence => true
end
