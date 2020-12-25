class LabelPolicy < ApplicationPolicy
  def create?
    good_project_member?
  end

  def update?
    good_project_member?(object: record.project)
  end

  def destroy?
    update?
  end
end
