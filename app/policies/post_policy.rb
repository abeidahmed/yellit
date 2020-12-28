class PostPolicy < ApplicationPolicy
  def new?
    good_project_member?
  end

  def edit?
    good_project_member?(object: record.project)
  end

  def update?
    edit?
  end
end
