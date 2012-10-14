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
  scope :mortal, :conditions => { :admin => false }

  def as_csv
    [ lastname, firstname, homephone, email ].join(',')
  end

  def to_label
    "#{firstname} #{lastname}"
  end

  def confirmed_for?(year)
    return false if lastconfirmed.blank?
    return false if lastconfirmed < year
    return true
  end

  def current_confirmation_year(n = Time.now)
    year = n.year
    month = n.month

    # if after July, then it's next year
    if month > 7
      return year
    else
      return (year-1)
    end
  end
end
