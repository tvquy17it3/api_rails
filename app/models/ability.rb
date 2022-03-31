# frozen_string_literal: true

class Ability
  include CanCan::Ability

  def initialize(user, controller_namespace)
    user ||= User.new # guest user (not logged in)
    # if user.role.user_role?
    #   can :read, User, id: user.id
    # end
    case controller_namespace
      when :admin
        if user.role.admin_role?
          can :manage, :all
          cannot :destroy, User, id: user.id
        end

        if user.role.manager_role?
          can %i(read banned unbanned search), User
          can :destroy, User do |u|
            u.id != user.id
          end
          cannot :destroy, User, role_id: 1
        end

        if user.role.user_role?
          cannot :manage, User
        end
      when :api_auth
        can :manage, User
        can [:create, :read, :list, :detail], Timesheet, user_id: user.id
      else
        can :read, User
    end
  end
end
