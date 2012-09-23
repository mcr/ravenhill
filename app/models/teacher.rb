class Teacher < ActiveRecord::Base
  attr_accessible :name, :room
  has_many :students
end
