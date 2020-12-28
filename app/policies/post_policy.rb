class PostPolicy < ApplicationPolicy
  def new?
    good_project_member?
  end

  def edit?
    allow_pending_users_but_redirect
  end

  def update?
    good_project_member?(object: record.project)
  end

  private
  def allow_pending_users_but_redirect
    user.has_project_membership?(record.project)
  end
end
