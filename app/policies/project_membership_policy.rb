class ProjectMembershipPolicy < ApplicationPolicy
  def create?
    good_project_owner?
  end

  def show?
    is_current_user? && user.project_invite_pending?(record.project)
  end

  def destroy?
    good_current_project_member? || good_project_owner?(object: record.project)
  end

  def decider?
    show?
  end

  def roller?
    good_project_owner?(object: record.project)
  end

  class Scope < Scope
    def resolve
      scope.project_memberships.includes(:user) if good_project_member?
    end
  end

  private
  def good_current_project_member?
    is_current_user? && good_project_member?(object: record.project)
  end

  def is_current_user?
    user == record.user
  end
end
