class ApplicationPolicy
  attr_reader :user, :record

  def initialize(user, record)
    raise Pundit::NotAuthorizedError, "Sign up or login to continue" unless user

    @user   = user
    @record = record
  end

  def index?
    false
  end

  def show?
    false
  end

  def create?
    false
  end

  def new?
    create?
  end

  def update?
    false
  end

  def edit?
    update?
  end

  def destroy?
    false
  end

  class Scope
    attr_reader :user, :scope

    def initialize(user, scope)
      raise Pundit::NotAuthorizedError, "Sign up or login to continue" unless user

      @user  = user
      @scope = scope
    end

    def resolve
      scope.all
    end

    def good_project_member?(object: scope)
      user.has_project_membership?(object) && user.project_invite_accepted?(object)
    end
  end

  def good_project_owner?(object: record)
    good_project_member?(object: object) && user.project_owner?(object)
  end

  def good_project_member?(object: record)
    user.has_project_membership?(object) && user.project_invite_accepted?(object)
  end

  def redirect_pending_user(object: record)
    user.has_project_membership?(object)
  end
end
