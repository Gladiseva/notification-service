# frozen_string_literal: true

class Ability
  include CanCan::Ability

  def initialize(user)
    if user.client?
      can :read, Notification, recipient_id: user.id
    elsif user.admin?
      can :manage, Notification, sender_id: user.id
    end
  end
end
