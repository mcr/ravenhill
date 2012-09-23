class Student < ActiveRecord::Base
  has_many :student_guardians, :foreign_key => :student_id
  has_many :guardians, :through => :student_guardians
  belongs_to :teacher

  scope :active,   :conditions => { :updated => true }
  scope :inactive, :conditions => { :updated => false }
  scope :graduated, :conditions => [ "teacher_id IS NULL" ]
  default_scope order('lastname ASC')

  def to_label
    "#{lastname}, #{firstname}"
  end

end
