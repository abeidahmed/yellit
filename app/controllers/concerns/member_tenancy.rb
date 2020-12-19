module MemberTenancy
  extend ActiveSupport::Concern

  def check_member_tenancy_for(object)
    if object.respond_to?(:project)
      redirect_to root_path if current_user.project_invite_pending?(object.project)
    else
      membership = current_user.find_project_membership(object)
      return redirect_to app_projects_path, notice: "You have been removed from the team" if membership.nil?
      redirect_to root_path if current_user.project_invite_pending?(object)
    end
  end
end