class PostPolicy < ApplicationPolicy
  def new?
    good_project_member?
  end

  def edit?
    new?
  end

  def update?
    edit?
  end
end
