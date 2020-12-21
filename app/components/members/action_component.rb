class Members::ActionComponent < ApplicationComponent
  attr_reader :current_user, :member, :project

  def initialize(current_user:, member:)
    @current_user = current_user
    @member       = member
    @project      = member.project
  end

  def render?
    current_user_is_owner? || current_user?
  end

  def current_user_is_owner?
    current_user.project_owner?(project)
  end

  def member_is_owner?
    member.project_owner?(project)
  end

  def current_user?
    current_user == member.user
  end
end
