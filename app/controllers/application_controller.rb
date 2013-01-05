class ApplicationController < ActionController::Base
  protect_from_forgery
  
  helper_method :current_user
  private

  def current_user
    @current_user ||=  User.find_by_remember_token(cookies[:remember_token]) if cookies[:remember_token]
  end
end
