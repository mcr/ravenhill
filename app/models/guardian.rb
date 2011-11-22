class Guardian < ActiveRecord::Base
  has_many :student_guardians, :foreign_key => :guardian_id
  has_many :students, :through => :student_guardians
end
