class Admin::StudentsController < Admin::AdminController
  before_filter :authenticate_guardian!
  before_filter :load_associations
  load_and_authorize_resource 

  active_scaffold :student do |config|
    config.list.per_page = 30
    config.list.columns = [
      :lastname, :firstname, 
      :grade,
      :guardians,
      :teacher,
      :updated_at
    ]
    config.create.columns = [
      :firstname, 
      :lastname, 
      :grade,
      :teacher,
    ]
    config.update.columns.exclude [
      :student_guardians
    ]
    config.create.columns.exclude [
      :student_guardians
    ]
    config.show.columns.exclude [
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

  def create
    do_create
    if @guardian
      @guardian.students << @record
      redirect_to admin_guardian_students_path(@guardian)
    else
      redirect_to admin_student_path(@record)
    end
  end

  protected
  def beginning_of_chain
    if @teacher 
      @teacher.students
    elsif @guardian
      @guardian.students
    else
      Student
    end
  end
  
  def do_new
    super
    if @guardian
      true
      #@guardian.students << @record
      # this results in duplicate records.
    end
  end
end
