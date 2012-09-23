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
  end

  def foo
    debugger
    puts "Hello"
  end
end
