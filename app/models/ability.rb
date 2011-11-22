class Ability
#  include CanCan::Ability

  def initialize
    can :read,   :all
    can :update, :all
  end
end
