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
end
