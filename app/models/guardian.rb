class Guardian < ActiveRecord::Base
  include FixtureSave
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable, :validatable
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, #:registerable,
         :recoverable, :rememberable, :trackable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me

  has_many :student_guardians, :foreign_key => :guardian_id
  has_many :students, :through => :student_guardians

  scope :active, lambda {
    includes(:students).merge(Student.active)
  }

  def as_csv
    [ lastname, firstname, homephone, email ].join(',')
  end
end
