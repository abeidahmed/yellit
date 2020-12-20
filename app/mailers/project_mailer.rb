class ProjectMailer < ApplicationMailer
  def project_invitation(membership, **options)
    @user       = membership.user
    @membership = membership
    @new_user   = options[:new_user]

    mail to: @user.email_address, subject: "You have an invitation to #{membership.project.name}"
  end
end
