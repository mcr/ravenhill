class TeachersController < ApplicationController
  before_filter :authenticate_guardian!
  load_and_authorize_resource 

  active_scaffold :teacher do |config|
  end
end
