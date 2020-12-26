class ApplicationController < ActionController::Base
  add_flash_types :success

  include Pundit
  include SessionsHelper

  def redirect_back_or_to(fallback_location, **args)
    redirect_back fallback_location: fallback_location, **args
  end
end
