class ApplicationController < ActionController::Base
  protect_from_forgery

  #check_authorization :unless => :devise_controller?
  before_filter :load_associations

  rescue_from CanCan::AccessDenied do |exception|
    Rails.logger.debug "Access denied on #{exception.action} #{exception.subject.inspect}"
    respond_to do |format|
      format.json { head :status => 403 }
      format.html { render :file => "#{Rails.root}/public/403.html", :status => 403 }
    end
  end

  protected

  def current_ability
    @current_ability ||= Ability.new(current_guardian, params[:format])
  end

  def authenticate_admin!
    authenticate_guardian!
    current_guardian.admin?
  end

  def load_associations
    if params[:teacher_id]
      @teacher = Teacher.find(params[:teacher_id])
    end
  end

end
