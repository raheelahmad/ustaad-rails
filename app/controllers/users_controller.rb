class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.new(params[:user])
    if @user.save
      cookies.permanent[:remember_token] = @user.remember_token
      redirect_to root_path, notice:"You have been signed up"
    else
      flash[:notice] = "Error signing up"
      render "new"
    end
  end
end
