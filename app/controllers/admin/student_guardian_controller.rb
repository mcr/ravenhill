class Admin::StudentGuardianController < Admin::AdminController
  before_filter :authenticate_guardian!
  load_and_authorize_resource 

  active_scaffold :student_guardian do |config|
  end
end
