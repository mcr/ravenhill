class Admin::TeachersController < Admin::AdminController
  before_filter :authenticate_admin!
  load_and_authorize_resource 

  active_scaffold :teacher do |config|
    #config.list.columns.exclude []
    config.create.columns.exclude [
      :students
    ]
    config.update.columns.exclude [
    ]
    config.columns[:students].form_ui = :select
    config.columns[:students].show_blank_record = false
    config.columns[:students].options = {:draggable_lists => true}
  end
end
