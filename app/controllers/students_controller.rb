class StudentsController < ApplicationController
  before_filter :authenticate_guardian!
  load_and_authorize_resource :through => :current_guardian

  before_filter :update_guardian_view

  def update_guardian_view
    if current_guardian.admin?
      active_scaffold_config.update.columns = [
	:guardians,
	:display,
	:firstname,
	:lastname,
	:grade,
	:teacher
      ]
    else
      active_scaffold_config.update.columns = [
	:display,
	:firstname,
	:lastname,
	:grade,
	:teacher
      ]
    end 
  end

  active_scaffold :student do |config|
    config.list.per_page = 30
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
    config.create.columns.exclude [
      :student_guardians
    ]

    config.columns[:teacher].show_blank_record = false
    #config.columns[:teacher].inplace_edit = :ajax
    config.columns[:teacher].form_ui = :select
    config.columns[:guardians].form_ui = :select
    config.columns[:display].form_ui = :checkbox
    config.columns[:display].label = "Include in directory?"


    config.columns[:grade].form_ui = :select
    config.columns[:grade].options = {
      :options => [ 'JK', 'SK', '1', '2', '3', '4', '5', '6' ]
    }
  end

  def beginning_of_chain
    if current_guardian.admin?
      if @teacher 
	@teacher.students
      else
	Student
      end
    else 
      current_guardian.students
    end
  end

end
