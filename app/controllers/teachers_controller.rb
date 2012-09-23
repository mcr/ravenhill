class TeachersController < ApplicationController
  before_filter :authenticate_guardian!
  load_and_authorize_resource 

  active_scaffold :teacher do |config|
    #config.list.columns.exclude []
    config.create.columns.exclude [
      :students
    ]
    config.update.columns.exclude [
      :students
    ]
  end
end
