# frozen_string_literal: true

class Ability
  include CanCan::Ability

  def initialize(user)
    if user.client?
      can [:read, :destroy], Notification, recipient_id: user.id
    elsif user.admin?
      can [:read, :create], Notification, sender_id: user.id
    end
  end
end
