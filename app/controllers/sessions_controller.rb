class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.authenticate(params[:email], params[:password])
    if user
      cookies[:remember_token] = user.remember_token
      redirect_to root_path, notice:'You are signed in'
    else
      flash[:error] = "Incorrect email or password"
      render "new"
    end
  end

  def destroy
    cookies[:remember_token] = nil
    redirect_to root_path, notice:"You have been signed out"
  end
end
