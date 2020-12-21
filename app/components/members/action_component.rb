class Members::ActionComponent < Members::BaseComponent
  attr_reader :current_user

  def initialize(current_user:, **args)
    super(**args)
    @current_user = current_user
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

  private
  def project
    member.project
  end
end
