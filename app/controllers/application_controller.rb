class ApplicationController < ActionController::Base
  protect_from_forgery
  
  helper_method :current_user, :authorize

  private

  def authorize
    if !current_user
      redirect_to root_path, notice:"You need to sign in first"
    end
  end

  def current_user
    @current_user ||=  User.find_by_remember_token(cookies[:remember_token]) if cookies[:remember_token]
  end
end
