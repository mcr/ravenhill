class CreateGuardians < ActiveRecord::Migration
  def change
    create_table :guardians do |t|
      t.string :firstname
      t.string :lastname
      t.integer :newsletters
      t.integer :updated
      t.string :address1
      t.string :address2
      t.string :city_province
      t.string :postalcode
      t.string :occupation
      t.string :homephone
      t.string :workphone
      t.string :email
      t.integer :include_email
      t.integer :communityeventino
      t.integer :CASC_CoChairs
      t.integer :Treasurer
      t.integer :Secretary
      t.integer :Volunteer_Coordinator_i
      t.integer :Fundraising_Events_i
      t.integer :Alternative_School_Advisory_i
      t.integer :OCASC
      t.integer :Arts
      t.integer :Education
      t.integer :Fundraising
      t.integer :PlayGround
      t.integer :Active_Safe_Routes_i
      t.integer :Sports_Committee_i
      t.integer :Library_Support_i
      t.integer :Sub_Lunches_i
      t.integer :Pizza_Lunches_i
      t.integer :Milk_Program_i
      t.integer :Lice_Check_Program_i
      t.integer :Visiting_Volunteer_i
      t.integer :Safe_Arrival_Program_i
      t.integer :Newsletter_Editor_i
      t.integer :Baking
      t.integer :Family_Directory_i
      t.integer :Website
      t.integer :InfoNightBBQ
      t.integer :Family_Breakfast_i
      t.integer :Holiday_Craft_Fair_i
      t.integer :MultiCultural_Potluck_i
      t.integer :Francesco_Coffee_i
      t.integer :QSP_Magazine_i
      t.integer :BerryCirusSale
      t.integer :Lecture_Series_i
      t.integer :Staff_Appreciation_i
      t.integer :Garden_Sale_i
      t.integer :Back_to_Nature_i

      t.timestamps
    end
  end
end
