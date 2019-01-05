class Trainingevent < ApplicationRecord
  attr_accessor :employeeid

  has_many :employees
  has_many :employees, through: :eventattendees

  validates :trainingeventname, presence: true
  validates :courseversionid, presence: true
  validates :eventdatetime, presence: true
  validates :employeeid, presence: true
  validates :signupsheet, presence: true
end
