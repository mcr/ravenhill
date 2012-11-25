class Admin::GuardiansController < Admin::AdminController
  before_filter :authenticate_guardian!, :except => [ :welcome ]
  load_and_authorize_resource :except => [ :welcome ]
  skip_authorization_check :only => [ :welcome ]

  def welcome
    if current_user
      @user = current_user
      show
    else
      redirect_to new_user_session_path
    end
  end

  def create_respond_to_html 
    @record.save!
    redirect_to admin_guardian_students_path(@record)
  end

  active_scaffold :guardian do |config|
    config.list.columns = [
      :email,
      :firstname, :lastname,
      :include_email,
      :students
    ]
    config.update.columns.exclude [
      :student_guardians,
      :students,
      :admin,
      :current_sign_in_at, :current_sign_in_ip,
      :last_sign_in_at, :last_sign_in_ip,
      :remember_created_at, :reset_password_sent_at,
      :updated, 
      :encrypted_password,
    ]
    config.create.columns = [
       :firstname,
       :lastname,
       :newsletters,
       :address1,
       :address2,
       :homephone,
       :workphone,
       :email,

       :include_email,
       :communityeventino,
       #:students
    ]
    config.update.columns = [
       :firstname,
       :lastname,
       :newsletters,
       :address1,
       :address2,
       :city_province,
       :postalcode,
       :occupation,
       :homephone,
       :workphone,
       :email,

       :include_email,
       :communityeventino,
       :CASC_CoChairs,
       :Treasurer,
       :Secretary,
       :Volunteer_Coordinator_i,
       :Fundraising_Events_i,
       :Alternative_School_Advisory_i,
       :OCASC,
       :Arts,
       :Education,
       :Fundraising,
       :PlayGround,
       :Active_Safe_Routes_i,
       :Sports_Committee_i,
       :Library_Support_i,
       :Sub_Lunches_i,
       :Pizza_Lunches_i,
       :Milk_Program_i,
       :Lice_Check_Program_i,
       :Visiting_Volunteer_i,
       :Safe_Arrival_Program_i,
       :Newsletter_Editor_i,
       :Baking,
       :Family_Directory_i,
       :Website,
       :InfoNightBBQ,
       :Family_Breakfast_i,
       :Holiday_Craft_Fair_i,
       :MultiCultural_Potluck_i,
       :Francesco_Coffee_i,
       :QSP_Magazine_i,
       :BerryCirusSale,
       :Lecture_Series_i,
       :Staff_Appreciation_i,
       :Garden_Sale_i,
       :Back_to_Nature_i,
    ]
    config.columns[:students].show_blank_record = true

    [ :include_email, :communityeventino, :CASC_CoChairs,
      :Treasurer, :Secretary, :Volunteer_Coordinator_i,
      :Fundraising_Events_i, :Alternative_School_Advisory_i,
      :OCASC, :Arts, :Education, :Fundraising, :PlayGround,
      :Active_Safe_Routes_i, :Sports_Committee_i,
      :Library_Support_i, :Sub_Lunches_i, :Pizza_Lunches_i,
      :Milk_Program_i, :Lice_Check_Program_i, :Visiting_Volunteer_i,
      :Safe_Arrival_Program_i, :Newsletter_Editor_i, :Baking,
      :Family_Directory_i, :Website, :InfoNightBBQ, :Family_Breakfast_i,
      :Holiday_Craft_Fair_i, :MultiCultural_Potluck_i, :Francesco_Coffee_i,
      :QSP_Magazine_i, :BerryCirusSale, :Lecture_Series_i,
      :Staff_Appreciation_i, :Garden_Sale_i, :Back_to_Nature_i].each { |thing|
      config.columns[thing].form_ui = :checkbox
      config.columns[thing].css_class = 'volunteerbox'
    }

    config.columns[:newsletters].form_ui = :select
    config.columns[:newsletters].options = { :options => [ 'Email', 'Paper', 'Both', 'None' ] }
  end


end
