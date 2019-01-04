class Trainingevent < ApplicationRecord
  has_many :employees
  has_many :employees, through: :eventattendees
  
  attr_accessor :employeeid
  
  validates :trainingeventname, :presence => true
  validates :courseversionid, :presence => true
  validates :eventdatetime, :presence => true
  validates :employeeid, :presence => true
  validates :signupsheet, :presence => true
end
