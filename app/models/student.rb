class Student < ActiveRecord::Base
  has_many :student_guardians, :foreign_key => :student_id
  has_many :guardians, :through => :student_guardians

  scope :active,   :conditions => { :updated => true }
  scope :inactive, :conditions => { :updated => false }
end
