class ProjectPolicy < ApplicationPolicy
  def show?
    redirect_pending_user
  end

  def edit?
    redirect_pending_user
  end

  def update?
    good_project_owner?
  end
end
