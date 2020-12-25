class LabelPolicy < ApplicationPolicy
  def create?
    good_project_member?
  end
end
