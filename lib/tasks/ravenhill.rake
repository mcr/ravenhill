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
    if !year.blank?
      Guardian.confirmed(2012).each { |g|
	unless guardians_seen[g]
	  guardians_seen[g] = true
	  
	  stuff = g.guardian_render(guardians_seen, students_seen)
	  if stuff
	    (listing, kidname) = stuff
	    listings[kidname] = listing
	  end
	end
      }

      dirtime=Time.now.to_s(:db)

      puts '<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN"     '
      puts ' "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">'
      puts '<html xmlns="http://www.w3.org/1999/xhtml">'
      puts '<head>'
      puts "<title>Churchill Family Directory (#{dirtime})</title>"
      puts '    <link rel="stylesheet" type="text/css" href="../../stylesheets/directory.css">'
      puts '    <link rel="stylesheet" type="text/css" media="print" href="../../stylesheets/directory-print.css">'
      puts '    '
      puts '  </head>'
      puts '  <body>'
      puts ''
      puts '    <h1>Churchill Family Directory</h1>'
      puts '    <h1>2012-2013</h1>'
      puts ''
      puts '<h2>About this Directory</h2>'
      puts '<div class="notice">The Churchill Alternative School Council (CASC) produces and distributes this directory for the sole purpose of its members. It is not available to other '
      puts 'organizations or businesses. Information in the directory is provided by permission of the parents of Churchill Alternative School. We try hard to ensure that the'
      puts 'directory is current and correct, however if changes, additions or corrections are required, please contact directory@churchillschoolnews.ca.'
      puts '<div class="warning">Reproduction by any means is strictly prohibited, unless for the personal use of CASC members</div>'
      puts '</div>'

      puts "<p class=\"small\"> As of:" + dirtime + "</p>\n"
      puts "<div class=\"directory\">\n"
      listings.keys.sort.each { |key|
	listing = listings[key]
	puts "<div class=\"entry\">\n"
	listing.each { |line|
	  unless line.blank?
	    puts line
	  end
	}
	puts "</div>\n"
      }
      puts "</div></html></body>"
    end
  end
end
