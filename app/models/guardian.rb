class Guardian < ActiveRecord::Base
  include FixtureSave
  # Include default devise modules. Others available are:
  # :confirmable, :validatable
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, #:registerable,
         :recoverable, :rememberable, :trackable,
         :token_authenticatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me

  has_many :student_guardians, :foreign_key => :guardian_id
  has_many :students, :through => :student_guardians

  scope :active, lambda {
    includes(:students).merge(Student.active)
  }
  scope :mortal, :conditions => { :admin => false }
  scope :unconfirmed, lambda { |year|
    { :conditions => [ "lastconfirmed IS NULL or lastconfirmed < ?", year ] }
  }

  scope :confirmed, lambda { |year|
    { :conditions => [ "lastconfirmed >= ?", year ] }
  }
  scope :accepted, :conditions => { :accepted => true }
  scope :declined, :conditions => { :accepted => false }

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

  def update_confirmation!(year = nil)
    year ||= current_confirmation_year
    self.lastconfirmed = year
  end

  def current_confirmation_year(n = Time.now)
    year  = n.year
    month = n.month

    # if after July, then it's next year
    if month > 7
      return year
    else
      return (year-1)
    end
  end

  def send_confirmation!(year = nil)
    year ||= current_confirmation_year
    unless confirmed_for?(year)
      confirmation_email!
      true
    else
      false
    end
  end

  def confirmation_email!
    email = ConfirmationMailer.confirm(self)
    email.deliver
  end

  def accept_email!
    email = ConfirmationMailer.accepted(self)
    email.deliver
  end

  def fullname
    "#{firstname} #{lastname}"
  end

  def magictoken
    ensure_authentication_token!
    authentication_token
  end

  def homephone613
    return '' if homephone.blank?

    @homephone613 ||= _homephone613
  end
  
  def _homephone613
    np = homephone.gsub(/ /,'').gsub(/\-/,'')
    if np[0..1]=="+1"
      np = np[2..(np.length)]
    end
    if np[0..2]=="613"
      np = np[3..(np.length)]
    end
    sprintf("%s-%s", np[0..2], np[3..6])
  end

  def guardian_render(guardians_seen = Hash.new, students_seen = Hash.new)
    kidname = nil
    kids = []
    parents = [ self ]
    guardians_seen[self]=true
    students.each { |s|
      unless students_seen[s]
	students_seen[s] = true
	kidname = s.lastname if kidname.blank?
	kids << s  # add this student to the family
	s.guardians.each { |g2|
	  unless guardians_seen[g2]
	    guardians_seen[g2] = true
	    parents << g2
	  end
	}
      end
    }
    return nil if kids.length == 0
    listing = []
    
    list = sprintf("<table><tr><td><span class=\"familyname\">%s</span></td><td class=\"children\">", kids[0].lastname)
    sep = ""
    kids.each { |k|
      list = list + sprintf("%s <span class=\"childname\">%s[<span class=\"teacher\">%s</span>]</span>", sep, k.firstname, k.teacher.name)
      sep=","
    }
    listing[0] = list + "</td></tr></table>"
    address=nil
    phone  =nil
    lastname = nil
    listing[1] = ""
    listing[2] = ""
    
    address_same_count = 0
    parents.each { |p|
      address = p.address1      if address.blank?
      phone   = p.homephone613  if phone.blank?
      if (p.address1 == address and p.homephone613 == phone)
	address_same_count += 1
      end
    }
    
    # if parents have the same address then list it once, followed by emails
    if address_same_count == parents.size
      listing[2] = sprintf("<span class=\"address\">%s</span> <span class=\"phone\">%s</span>", address, phone)
      
      names = []
      samenames = []
      
      # see if parents have the same lastname.
      parents.each { |p|
	lastname = p.lastname     if lastname.blank?
	if lastname == p.lastname
	  samenames << p.firstname
	end
	names << p.fullname
	
	unless p.email.blank? || !p.include_email?
	  listing << sprintf("<span class=\"email\">%s</span>", p.email)
	end
      }
      
      listing[1] = "<span class=\"guardians\">"
      addlast = false
      if samenames.size == parents.size
	names = samenames
	addlast = true
      end

      sep=""
      names.each { |n|
	listing[1] += sprintf("%s<span class=\"parentname\">%s</span>", sep, n)
	sep=" and "
      }
      
      if addlast
	listing[1] += " " + lastname 
      end
      listing[1] += "</span>"
      
    else
      # otherwise, list each one, 
      
      parents.each { |p|
	listing << sprintf("<span class=\"guardians\"><span class=\"parentname\">%s %s</span></span>", p.firstname, p.lastname)
	listing << sprintf("<span class=\"address\">%s</span> <span class=\"phone\">%s</span>", p.address1, p.homephone613)
	unless p.email.blank? || !p.include_email?
	  listing << sprintf("<span class=\"email\">%s</span>", p.email)
	end
      }
    end
    
    return listing,kidname
  end
  
end
