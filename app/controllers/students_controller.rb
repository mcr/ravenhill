class StudentsController < ApplicationController
  before_filter :authenticate_guardian!
  load_and_authorize_resource 

  active_scaffold :student do |config|
    config.list.columns = [
      :lastname, :firstname, 
      :grade,
      :guardians,
      :teacher,
      :updated_at
    ]
    config.update.columns.exclude [
      :student_guardians
    ]

    config.columns[:teacher].show_blank_record = false
    config.columns[:teacher].inplace_edit = :ajax
    config.columns[:teacher].form_ui = :select
    config.columns[:guardians].form_ui = :select
  end

end
