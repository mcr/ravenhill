class ApplicationController < ActionController::Base
  protect_from_forgery

  #check_authorization :unless => :devise_controller?

  rescue_from CanCan::AccessDenied do |exception|
    Rails.logger.debug "Access denied on #{exception.action} #{exception.subject.inspect}"
    respond_to do |format|
      format.json { head :status => 403 }
      format.html { render :file => "#{Rails.root}/public/403.html", :status => 403 }
    end
  end

  protected

  def current_ability
    @current_ability ||= Ability.new(current_user, params[:format])
  end

end
