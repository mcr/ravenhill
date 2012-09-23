class Ability
  include CanCan::Ability

  def initialize(guardian, format)
    guardian ||= Guardian.new

    Rails.logger.debug "Access ability setup for #{guardian.email}, format=#{format}"

    if guardian.admin?
      can :read,   :all
      can :update, :all
      can :create, :all
    else
      can :read,   Guardian, :id => guardian.id
      can :update, Guardian, :id => guardian.id
      can [:read, :update],   Student do |student|
	student.guardians.inject(false) { |result, guard|
	  result ||= (guard.id == guardian.id)
	}
      end
    end
  end
end
