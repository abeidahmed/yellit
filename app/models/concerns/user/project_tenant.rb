class User
  module ProjectTenant
    def has_project_membership?(project)
      project_memberships.exists?(project_id: project.id)
    end

    def project_invite_accepted?(project)
      find_project_membership(project).join_date?
    end

    def project_invite_pending?(project)
      !project_invite_accepted?(project)
    end

    def project_owner?(project)
      find_project_membership(project).owner?
    end

    def find_project_membership(project)
      project_memberships.find_by(project_id: project)
    end
  end
end
