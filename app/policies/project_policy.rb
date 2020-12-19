class ProjectPolicy < ApplicationPolicy
  def update?
    good_project_owner?
  end
end
