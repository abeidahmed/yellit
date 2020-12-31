class ProjectMembership
  class Tombstone
    def initialize(membership:, current_user:)
      @membership   = membership
      @current_user = current_user
    end

    def needs_partner_owner?
      lone_owner? && current_user_is_project_owner? && current_user?
    end

    private

    attr_reader :membership, :current_user

    def current_user_is_project_owner?
      current_user.project_owner?(project)
    end

    def current_user?
      current_user == membership.user
    end

    def lone_owner?
      total_owners == 1
    end

    def total_owners
      project.total_owners
    end

    def project
      membership.project
    end
  end
end
