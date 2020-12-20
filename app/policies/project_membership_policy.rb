class ProjectMembershipPolicy < ApplicationPolicy
  def create?
    good_project_owner?
  end

  class Scope < Scope
    def resolve
      scope.project_memberships.includes(:user) if good_project_member?
    end
  end
end
