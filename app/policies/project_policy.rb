class ProjectPolicy < ApplicationPolicy
  def edit?
    allow_pending_users_but_redirect
  end

  def update?
    good_project_owner?
  end

  private
  def allow_pending_users_but_redirect
    user.has_project_membership?(record)
  end
end
