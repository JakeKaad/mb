class Ability
  include CanCan::Ability


  def initialize(user)
    user ||= User.new

    case user
    when User
      can :manage, Company, id: user.company.id
      can :manage, Event, company_id: user.company.id
      can :manage, Note
      can :manage, Info
      can :manage, User
      can :manage, Document
    when Customer

    end
  end
end
