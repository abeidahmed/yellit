class PostPolicy < ApplicationPolicy
  def new?
    good_project_member?
  end

  def edit?
    redirect_pending_user(object: record.project)
  end

  def update?
    good_project_member?(object: record.project)
  end
end
