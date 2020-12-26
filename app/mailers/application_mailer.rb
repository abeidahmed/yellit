class ApplicationMailer < ActionMailer::Base
  include SignedIdHelper
  helper :signed_id

  default from: "support@yellit.space"
  layout "mailer"
end
