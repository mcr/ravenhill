class StudentsController < ApplicationController
  before_filter :authenticate_guardian!
  load_and_authorize_resource 

  active_scaffold :student do |config|
  end
end
