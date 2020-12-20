class App::ProjectInvitationsController < App::BaseController
  layout "slate"

  def show
    skip_authorization
  end
end
