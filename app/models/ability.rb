class Ability
  include CanCan::Ability

  def initialize(user, format)
    can :read,   :all
    can :update, :all
    can :create, :all
  end
end
