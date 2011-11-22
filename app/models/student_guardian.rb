class StudentGuardian < ActiveRecord::Base
  belongs_to :student
  belongs_to :guardian
end
