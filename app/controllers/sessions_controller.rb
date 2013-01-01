class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.authenticate(params[:email], params[:password])
    if user
      session[:user_id] = user.id
      redirect_to root_path, notice:'You are signed in'
    else
      flash[:error] = "Incorrect email or password"
      render "new"
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_path, notice:"You have been signed out"
  end
end
