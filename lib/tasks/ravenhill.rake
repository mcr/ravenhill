# -*- ruby -*-

namespace :ravenhill do
  desc "Print list of volunteers, per category"
  task :volunteers  => :environment do
    list = [
"CASC_CoChairs",
"Treasurer",
"Secretary",
"Volunteer_Coordinator_i",
"Fundraising_Events_i",
"Alternative_School_Advisory_i",
"OCASC",
"Arts",
"Education",
"Fundraising",
"PlayGround",
"Active_Safe_Routes_i",
"Sports_Committee_i",
"Library_Support_i",
"Sub_Lunches_i",
"Pizza_Lunches_i",
"Milk_Program_i",
"Lice_Check_Program_i",
"Visiting_Volunteer_i",
"Safe_Arrival_Program_i",
"Newsletter_Editor_i",
"Baking",
"Family_Directory_i",
"Website",
"InfoNightBBQ",
"Family_Breakfast_i",
"Holiday_Craft_Fair_i",
"MultiCultural_Potluck_i",
"Francesco_Coffee_i",
"QSP_Magazine_i",
"BerryCirusSale",
"Lecture_Series_i",
"Staff_Appreciation_i",
"Garden_Sale_i",
"Back_to_Nature_i"
    ]
    list.each { |thing|
      puts "\n\nVolunteers for #{thing}\n"
      Guardian.active.each { |guardian|
        yes_thing=guardian.send(thing)
        if(yes_thing!=0)
          puts ","+guardian.as_csv
        end
      }
    }
  end

  desc "Remove kids that have no valid teacher"
  task :graduated => :environment do
    Student.graduated.delete_all
  end

  desc "Remove parents that have no children"
  task :emptynests => :environment do
    Guardian.mortal.each { |p|
      if p.students.count == 0
	puts "Removing parent: #{p.firstname} #{p.lastname}"
	p.delete unless ENV['JUSTKIDDING']
      end
    }
  end

  desc "Send out opt-in confirmation emails to guardians who have not confirmed"
  task :optinemails => :environment do
    year = ENV['YEAR'] || 2012
    Guardian.unconfirmed(2012).each { |g|
      unless g.email.blank?
	if g.send_confirmation!
	  puts "Sending confirmation email to #{g.email}"
	  sleep 60
	else
	  puts "Already confirmed from #{g.email}"
	end
      end
    }
  end

  desc "List of students with no email"
  task :noemails => :environment do
    Guardian.find_all_by_email(nil).each { |g|
      s1 = g.students.first
      if s1 && s1.guardians.find_all_by_email(nil).count == s1.guardians.count
	puts "#{s1.teachername},#{s1.fullname}\n"
      end
    }
  end

  desc "Send out opt-in confirmation emails to one guardian: GUARDIAN=XX"
  task :optinemail => :environment do
    email = ENV['EMAIL']
    if ENV['GUARDIAN']
      gnum = ENV['GUARDIAN']
      if gnum.blank?
	puts "GUARDIAN=XXX must be an integer" 
	return
      end
      gnum = gnum.to_i
      g = Guardian.find(gnum)
    elsif email
      g = Guardian.find_by_email(email)
      unless g
	puts "EMAIL=#{email} not found"
	return
      end
    else
      puts "GUARDIAN=XXX or EMAIL=XXX please"
      return
    end
	
    puts "Sending confirmation email to #{g.email}"
    g.confirmation_email!
  end

  desc "Send out thank you to those who confirmed in YEAR=XXXX"
  task :thankyou => :environment do
    year = ENV['YEAR']
    if !year.blank?
      Guardian.confirmed(2012).each { |g|
	g.accept_email!
	sleep 20
	puts "Sending thank you email to #{g.email}"
      }
    end
  end

  desc "List all students and guardians that are confirmed in YEAR=XXXX"
  task :directory => :environment do
    year = ENV['YEAR']
    students_seen = Hash.new
    guardians_seen= Hash.new
    listings = Hash.new
    persons = Hash.new
    if !year.blank?
      Guardian.confirmed(2012).each { |g|
	unless guardians_seen[g]
	  guardians_seen[g] = true
	  kidname = nil
	  kids = []
	  parents = [ g ]
	  g.students.each { |s|
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
	  next if kids.length == 0
	  listing = []

	  list = kids[0].lastname
	  sep = ""
	  kids.each { |k|
	    list = list + sprintf("%s %s[%s]", sep, k.firstname, k.teacher.name)
	    sep=","
	  }
	  list = list 
	  listing[0] = list
	  address=nil
	  phone  =nil
	  lastname = nil
	  names = []
	  listing[1] = ""
	  listing[2] = "ADDRESS"
	  parents.each { |p|
	    if (p.address1 != address or p.homephone613 != phone)
	      address = p.address1      if address.blank?
	      phone   = p.homephone613  if phone.blank?
	      unless lastname
		lastname = p.lastname
	      end
	      if lastname == p.lastname
		names << p.firstname
	      else
		listing << sprintf("   %s %s", p.firstname, p.lastname)
	      	listing << sprintf("     %30s %s", p.address1, p.homephone613)
	      end
	      unless p.email.blank? || !p.include_email
		listing << sprintf("     %30s", p.email)
	      end
	    end
	  }
	  sep=""
	  listing[1]="   "
	  names.each { |n|
	    listing[1] = listing[1] + sprintf("%s%s", sep, n)
	    sep=" and "
	  }
	  listing[1] = listing[1] + " " + lastname 
	  listing[2] = sprintf("     %30s %s", address, phone)

	  listings[kidname] = listing 
	end
      }
      listings.keys.sort.each { |key|
	listing = listings[key]
	listing.each { |line|
	  unless line.blank?
	    puts line
	  end
	}
      }
    end
  end
end
