class GuardiansController < ApplicationController
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
    config.columns[:students].show_blank_record = false
    config.columns[:email].inplace_edit = true 
    config.columns[:firstname].inplace_edit = true 
    config.columns[:lastname].inplace_edit = true 
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
  end

  def foo
    debugger
    puts "Hello"
  end

  # a get routine, return a page giving some Guardian details,
  # and a place to opt-in, or opt-out.
  def optin
    auditlogger.info "IP address #{request.ip} visited optin page for id\##{@guardian.id} email:#{@guardian.email}"
    # just render
  end

  # process POST for opt-in/opt-out.
  def confirm_optin
    if params[:accepted].blank?
      redirect_to optin_guardian_path(@guardian)
      return;
    end
    accepted = @guardian.accepted = (params[:accepted].to_i == 1)

    auditlogger.info "IP address #{request.ip} marked id\##{@guardian.id} email:#{@guardian.email} as accepted=#{@guardian.accepted}"
    @guardian.updateconfirmation!

    if(accepted) 
      redirect_to guardian_path(@guardian)
    else
      @guardian.authentication_token = nil
      redirect_to '/'
    end

    @guardian.save!
  end

  # get a page that permits confirmation that we have a wrong email
  def wrongemail
    auditlogger.info "IP address #{request.ip} visited wrongemail page for id\##{@guardian.id} email:#{@guardian.email}"
    # just render
  end

  # process POST for wrong email
  def confirm_wrongemail
    @guardian.wrongemail_at = Time.now
    auditlogger.info "IP address #{request.ip} marked id\##{@guardian.id} email:#{@guardian.email} as invalid at #{@guardian.wrongemail_at}"
    @guardian.email = nil
    @guardian.authentication_token = nil
    @guardian.save!
    redirect_to '/'
  end

end
