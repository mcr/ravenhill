class Guardian < ActiveRecord::Base
  has_many :student_guardians, :foreign_key => :guardian_id
  has_many :students, :through => :student_guardians

  scope :active, lambda {
    includes(:students).merge(Student.active)
  }

  def as_csv
    [ lastname, firstname, homephone, email ].join(',')
  end
end
