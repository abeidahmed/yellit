class ProjectMembershipPolicy < ApplicationPolicy
  def create?
    good_project_owner?
  end

  def show?
    is_current_user? && user.project_invite_pending?(record.project)
  end

  class Scope < Scope
    def resolve
      scope.project_memberships.includes(:user) if good_project_member?
    end
  end

  private
  def is_current_user?
    user == record.user
  end
end
