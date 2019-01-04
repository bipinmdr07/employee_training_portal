class Courseversion < ApplicationRecord
  belongs_to :course
  belongs_to :version
  
  validates :course_id, :presence => true
  validates :version_id, :presence => true
end
