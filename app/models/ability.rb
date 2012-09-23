class Ability
  include CanCan::Ability

  def initialize(guardian, format)
    guardian ||= Guardian.new

    kind = guardian.admin? ? "Admin" : "Normal"
    Rails.logger.debug "#{kind} access ability setup for #{guardian.email}, format=#{format}"

    @guardian = guardian

    if @guardian.admin?
      can :read,   :all
      can :update, :all
      can :create, :all
    else
      can :read,   Guardian, :id => @guardian.id
      can :update, Guardian, :id => @guardian.id
      can [:read, :update],   Student do |student|
	student.guardians.inject(false) { |result, guard|
	  result ||= (guard.id == @guardian.id)
	}
      end
    end
  end
end
