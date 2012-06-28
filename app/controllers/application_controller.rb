class ApplicationController < ActionController::Base
  protect_from_forgery

  def must_be_admin!
    raise "Unauthorised access" unless current_user and current_user.admin?
  end
end
