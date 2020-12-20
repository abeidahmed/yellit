class ProjectMembershipPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.project_memberships.includes(:user) if good_project_member?
    end
  end
end
