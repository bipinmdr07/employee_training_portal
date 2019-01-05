class Coursesforrole < ApplicationRecord
  belongs_to :course
  belongs_to :role

  validates :course_id, presence: true
  validates :role_id, presence: true
end
