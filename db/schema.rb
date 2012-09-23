# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20120923200246) do

  create_table "guardians", :force => true do |t|
    t.string   "firstname"
    t.string   "lastname"
    t.string   "newsletters"
    t.integer  "updated"
    t.string   "address1"
    t.string   "address2"
    t.string   "city_province"
    t.string   "postalcode"
    t.string   "occupation"
    t.string   "homephone"
    t.string   "workphone"
    t.string   "email"
    t.integer  "include_email"
    t.integer  "communityeventino"
    t.integer  "CASC_CoChairs"
    t.integer  "Treasurer"
    t.integer  "Secretary"
    t.integer  "Volunteer_Coordinator_i"
    t.integer  "Fundraising_Events_i"
    t.integer  "Alternative_School_Advisory_i"
    t.integer  "OCASC"
    t.integer  "Arts"
    t.integer  "Education"
    t.integer  "Fundraising"
    t.integer  "PlayGround"
    t.integer  "Active_Safe_Routes_i"
    t.integer  "Sports_Committee_i"
    t.integer  "Library_Support_i"
    t.integer  "Sub_Lunches_i"
    t.integer  "Pizza_Lunches_i"
    t.integer  "Milk_Program_i"
    t.integer  "Lice_Check_Program_i"
    t.integer  "Visiting_Volunteer_i"
    t.integer  "Safe_Arrival_Program_i"
    t.integer  "Newsletter_Editor_i"
    t.integer  "Baking"
    t.integer  "Family_Directory_i"
    t.integer  "Website"
    t.integer  "InfoNightBBQ"
    t.integer  "Family_Breakfast_i"
    t.integer  "Holiday_Craft_Fair_i"
    t.integer  "MultiCultural_Potluck_i"
    t.integer  "Francesco_Coffee_i"
    t.integer  "QSP_Magazine_i"
    t.integer  "BerryCirusSale"
    t.integer  "Lecture_Series_i"
    t.integer  "Staff_Appreciation_i"
    t.integer  "Garden_Sale_i"
    t.integer  "Back_to_Nature_i"
    t.datetime "created_at",                                       :null => false
    t.datetime "updated_at",                                       :null => false
    t.string   "encrypted_password",            :default => "",    :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                 :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.boolean  "admin",                         :default => false
  end

  add_index "guardians", ["reset_password_token"], :name => "index_guardians_on_reset_password_token", :unique => true

  create_table "student_guardians", :force => true do |t|
    t.integer  "student_id"
    t.integer  "guardian_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "students", :force => true do |t|
    t.string   "firstname"
    t.string   "lastname"
    t.string   "grade"
    t.integer  "teacher_id"
    t.integer  "display"
    t.boolean  "updated"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "teachers", :force => true do |t|
    t.string   "name"
    t.string   "room"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

end
